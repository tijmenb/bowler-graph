# Generates a Dot/PNG for a single Pinfile
$:.unshift( "../lib" );

require "bowler"
require "gviz"
require "active_support/all"
require "pp"

def safe_app_name(app_name)
  app_name.to_s.gsub('_', '').gsub('-', '')
end

simple = Gviz.new
simple.graph do
  path = File.expand_path(ARGV[0])
  dep_tree = Bowler::DependencyTree.load(path)
  tree = dep_tree.instance_variable_get('@definition').tree

  # *everything* depends on static
  SKIP = %w[]

  tree.each do |key, targets|
    app_name = safe_app_name(key)
    next if app_name.in?(SKIP)

    # Create a node for the app
    node app_name.to_sym, label: key

    # Draw the connections between this app and its dependencies
    dependent_apps = targets.map { |t| safe_app_name(t) } - SKIP
    route app_name.to_sym => dependent_apps
  end

  nodes shape: 'polygon'

  global(rankdir: "RL", rankseq: 'equally')
end

simple.save("build/#{ARGV[0].split('/').last}", :png)
