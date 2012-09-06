require 'Find'
require 'pp'

the_path = "lab/media"

#  moof = []
#  Find.find(the_path) do |path|
#    moof << path
#  end
#  pp moof
#  p "farkle"
pp "------------------"

p Dir.pwd
p the_path

big_path = the_path + "/**/*.mp3"
p big_path

a = Dir.glob( the_path + "/**/*.mp3")
pp "-----------------------"

course_types =[]
pp Dir.glob(the_path)

Dir.glob(the_path + "/*").each do |p|
  if File.directory?(p) then 
    course_types << File.basename(p) 
  end  
end

pp course_types
