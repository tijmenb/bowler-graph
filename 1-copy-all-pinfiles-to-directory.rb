# Puts a copy of all Pinfile version in `./pinfiles`
require 'grit'

repo = Grit::Repo.new("../development")

`mkdir pinfiles`

repo.log('master', 'Pinfile').reverse.each_with_index do |line, i|
  puts `cd ../development && git checkout #{line.sha} -- Pinfile && cp Pinfile ../bowler-graph/pinfiles/Pinfile-#{line.committed_date.to_i}`
end
