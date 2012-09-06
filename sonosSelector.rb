
# Sept 1, 2012 hjw
# small selector program to filter the audio library for courses and to set 
# it up for use on a course.
#
# Need to be able to select course, and languages and then create softlinks
# in the appropriate public directory on the NAS drives for use by the SONOS
# system.
#
# After creation of the softlinks the index will have to be rebuilt on the sonos
# controller.
#     
# gives a drop down list, with its selection displayed below it, then below 
# that it gives a bunch of check boxes and a button to show an alert box 
# that displays the checked items
#
# want to have a drop down list with the course types, followed by 
# a section of checkboxes with the available languages for the selected type
#

Shoes.app :title => "Audio Selector" do #, :width => 640, :height => 400 do
  # ------ Actions class ------------------------
  class Actions 
    @myApp

    def initialize(myApp)
      @myApp = myApp
    end
  end #-- end Actions class ---------------
  
  # ----- createCourseList -----------------------
  # get list of "course types" for drop down menu ... this list may not be strictly
  # limited to course types, it may also have other general groupings ie 
  # "special chantings", "talks", etc.  Either way, its a list of the directories
  # at the first level of top_of_library
  def createCourseList(root)
    course_types=[]
    Dir.glob(root + "/*").each do |p|
      if File.directory?(p) then 
        course_types << File.basename(p) 
      end  
    end
    course_types
  end # ---- end createCourseList -----------------

  top_of_library = "/Users/hjw/Documents/DhammaService/sonos/media"
  course_types = createCourseList(top_of_library)
  
  #background aliceblue.. black, :angle => -90
  #background  firebrick
      background deepskyblue.. ghostwhite, :angle => 90,
        :margin => 0
  stack do
    stack do
      background black
      stack :margin_left => 118, :margin_top => 20 do
        para "Audio Library", :stroke => "#eee", :margin_top => 8, :margin_left => 17, 
          :margin_bottom => 0
        @title = title "Choose A Course!", :stroke => white, :margin => 4, :margin_left => 14,
          :margin_top => 0, :font => "Coolvetica"
      end
      background "rgb(66, 66, 66, 180)".."rgb(0, 0, 0, 0)", :height => 0.7
      background "rgb(66, 66, 66, 100)".."rgb(255, 255, 255, 0)", :height => 20, :bottom => 0
    end
    flow :margin => 5, :height => 350 do
      flow :margin_top => 20, :margin_left => 118  do
        stack  do
          flow do
            #background "rgb(240, 248, 255, 100)".."rgb(255, 255, 255, 0)"
            tagline("Choose a course type:\n")
            @course_box = list_box :items => course_types
          end

          @languages_flow = flow :hidden => true do
            para "choose the desired languages:\n",:stroke => firebrick
          end

          @course_box.change do |box|
            @languages_flow.style :hidden => false 
            #@languages_boxes = 
          end
        end
      end
    end
  #flow  :margin_top => 20, :margin_left => 50 do
    #flow  :bottom => 0, :left => 0 do
    flow  do
      button "Create New Library"  do
        close()
      end
      button "Add Another Course"  do
        close()
      end
      button "show selections"  do
        close()
      end
      button "Quit"  do
        close()
      end
    end
  end

end
