# coding: utf-8
 
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

Shoes.app :title => "Audio Selector", :width => 640 do
  background deepskyblue.. ghostwhite, :angle => 90, :margin => 0
  
  # ------ Actions class ------------------------
  class Actions 
    @myApp

    def initialize(myApp)
      @myApp = myApp
    end
  end #-- end Actions class ---------------
  
  #-- AudioLibrary class ------------------
  # need to pass the root path as a string to the class
  # when initializing it.  That path must be a valid, accessible
  # directory.
  #-----------------------------------------
  class AudioLibrary
    attr_reader :library_root, :chosen_directories

    def initialize(root)
      if File.directory?(root) then
        @library_root = root
        @course_types = Hash.new   # a hash with the keys being the directories and 
                             # the values being the full path to that dir.
        @chosen_directories =[] # a list of paths to be included in the library
      end
      debug ("@library_root is: #{@library_root}")
    end #-- initialize

    #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    # returns an array of strings containing the course types
    #this list may not be strictly
    # limited to course types, it may also have other general groupings ie 
    # "special chantings", "talks", etc.  Either way, its a list of the directories
    # at the first level of top_of_library
    #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    def createCourseList
      course_types=[]
      Dir.glob(@library_root + "/*").each do |p|
        if File.directory?(p) then 
          @course_types[File.basename(p)] = p
          course_types << File.basename(p)
        end  
      end
      #debug("@course_types is #{@course_types}")
      course_types
    end #-- createCourseList 

    #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    # get list of "languages" for use in a checkbox grid.
    #
    #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    def createLanguageList(courseType)
      languages=[]
      Dir.glob(@library_root +"/" + courseType + "/*").each do |p|
        if File.directory?(p) then 
          languages << File.basename(p) 
        end  
      end
      debug(" language list is: #{languages}")
      languages
    end # ---- end createLanguageList -----------------

  end #-- AudioLibrary class ----------------
   

  top_of_library = "/Users/hjw/Documents/DhammaService/sonos/media"

  @myAudioLibrary = AudioLibrary.new(top_of_library)
  @course_types = @myAudioLibrary.createCourseList
  
  # @button_bar is a flow,  pinned to the bottom of the window.
  # In order for this to work it must be declared before
  # any other stacks/ flows and it must have a height specified.
  #@button_bar = flow :bottom => 0, :height => 60 do
  lib_root = ""
  @button_bar_area = stack :bottom => 10, :height => 60 do
    @button_bar = flow do
      button "Create New Library"  do
        lib_root = ask_open_folder
        @status_area.append do
          para lib_root
        end
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
    @status_area = flow  do
      caption("You selected: ")
    end

  end
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
    flow :margin => 5 do
      flow :margin_top => 20, :margin_left => 90  do
        caption("Choose a course type\n")
        @course_box = list_box :items => @course_types, :margin_left => 60
      end

      @languages_flow = flow :hidden => true do
        para "choose the desired languages:\n",:stroke => firebrick
      end
      @course_box.change do 
        @languages_flow.style :hidden => false 
        @languages_boxes = @myAudioLibrary.createLanguageList(@course_box.text)
        @languages_flow.append do
          @languages_boxes.map! do |lang|
            @c =check; para lang, :margin_right =>25
            [@c, lang]
          end
          debug("languages_boxes = #{@languages_boxes}")
        end
      end
    end
  end
end
