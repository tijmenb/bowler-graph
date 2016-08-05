files = Dir.glob('build/Pinfile*.png').to_a.sort.join(' ')
puts `convert -delay 35 -loop 0 #{files} animated.gif`
