require 'rainbow'

task :build do
  `nanoc`
end

task :deploy => [:build] do
  
end

task :serve do
  PageServer.serve!
end

task :setup do
  silence = "2>/dev/null"

  print "Creating source branch... "
  `git branch -m master source #{silence}`
  `git push -u origin source #{silence}`
  print "done".color(:green)

  print "Creating output directory... "
  url = `git config --get remote.origin.url`.chomp
  `git clone #{url} output #{silence}`
  print "done".color(:green)

  print "Isolating master branch... "
  `cd output && git symbolic-ref HEAD refs/heads/master && rm .git/index && git clean -fdx && touch index.html && git add . && git commit -a -m 'First markup' && git push origin master #{silence}`
  print "done".color(:green)
end