
Shoes.app do
     @first_list = ['Frances Johnson', 'Ignatius J. Reilly',
            'Winston Niles Rumfoord']
     @slot = stack { para "Choose a dude"}

     @slot.append do
       list_box :items => @first_list, 
              :width => 220,
              :choose => @first_list[0] do |my_list|
                @dude.text = my_list.text
       end
     end
     @slot.append do
      @dude = para "No dude selected"
     end
     para "fubar, fubar, fubar"
     @check_list = Array.new(@first_list)
        stack do
          @check_list.map! do |name|
             flow { @c = check; para name }
               [@c, name]
             end
            button "What's been checked?" do
            selected = @check_list.map { |c, name| name if c.checked? }.compact
               alert("You selected: " + selected.join(', '))
           end
       end
end
