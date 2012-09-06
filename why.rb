#class Dictionary < Shoes
#  url '/',     :index
#  url '(\w+)', :word
#  def index 
#    stack do
#      title "Enter a Word" 
#      @word = edit_line 
#      button "OK" do
#        visit "/^{@word.text}"
#      end
#    end 
#  end
#  
#  def word(string)
#    stack do
#      para "No definition found for ^{string}.",
#        "Sorry this doesn't actually work."
#    end 
#  end 
#  Shoes.app
#end

#class BookList <Shoes
#  url '/',      :index
#  url '/twain',  :twain
#  url '/kv',     :vonnegut
#
#  def index
#    para "Books I've read: ",
#      link("by Mar Twain", :click => "/twain")
#  end
#
#  def twain
#    para "Just Huck Finn.\n",
#      link("go back.", :click => "/")
#  end
#end
#Shoes.app :width =>400, :height => 500
#

Shoes.app :title => "first shoes gui app" do
  class Actions
    @myApp

    def initialize(myApp)
      @myApp = myApp
    end

    def doLogin(username, password)
      @myApp.app do
        if username == "fubar" and password == "fu" 
          alert "Successful login!"
        else
          alert "Incorrect username / password combination."
        end
      end
    end
  end
    stack do
      background black
      stack :margin_left => 118 do
        para "The Shoes Manual", :stroke => "#eee", :margin_top => 8, :margin_left => 17, 
          :margin_bottom => 0
        @title = title "My Title", :stroke => white, :margin => 4, :margin_left => 14,
          :margin_top => 0, :font => "Coolvetica"
      end
      background "rgb(66, 66, 66, 180)".."rgb(0, 0, 0, 0)", :height => 0.7
      background "rgb(66, 66, 66, 100)".."rgb(255, 255, 255, 0)", :height => 20, :bottom => 0
    end

  stack :margin => 10 do
    @myActions = Actions.new(self)


    #background aliceblue, :curve => 9
    background deepskyblue.. ghostwhite, :angle => 90, :curve => 9
    para "alignment" , :align => "right"
    stack :margin =>10 do
      background firebrick.. cornsilk, :angle => -135, :curve => 9

      flow do
        flow :width => 0.3 do
          #background firebrick.. cornsilk, :radius => 6
          #background aliceblue.. cornsilk, :angle => 90, :curve => 9
          para "@username: ",   :align => "right"
        end
        @username = edit_line :margin_bottom => 5, :text => "@username"
      end
      flow do
        flow :width => 0.3 do
          #background firebrick.. cornsilk, :radius => 6
          #background aliceblue.. cornsilk, :angle => 90, :curve => 9
          para "@password: ",   :align => "right"
        end
        @password = edit_line :margin_bottom => 5, :text => "@password"
      end
    end
#    flow do
#      para "password disconbooble: "
#      password = edit_line
##    end

    rotate 45
    para "password: ", :text => "password"
    para "is this rotated too?"
    password2 = edit_line :text => "password2"

    button "login" do
      @myActions.doLogin(@username.text, @password.text)
    end
  end
end

