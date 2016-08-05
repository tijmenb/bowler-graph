# 2. Create PNGs for all Pinfiles in ./pinfiles
files = Dir.glob("pinfiles/*").sort

files.each do |f|
  `ruby generate.rb "#{f}"`
end
