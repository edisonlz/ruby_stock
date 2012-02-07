module Utility
  
  module WindowRealTime
    ##
    # 日线
    class RealTimeStockWindow < Wx::Window
      SPAN_WIDTH=15
      ##
      #初始化
      def initialize(parent,x=10,y=10)
        super(parent)
        # Create the font we'll use to create our pre-defined fonts for the painting
        @font = Wx::Font.new(18,Wx::FONTFAMILY_TELETYPE,Wx::FONTSTYLE_NORMAL,Wx::FONTWEIGHT_NORMAL)
        @x=x
        @y=y
        evt_paint :on_paint
      end
      ##
      #To Draw
      def on_paint(evt)
        ##
        #draw window context
        paint do |dc|
          #[x,最高，最低，开，收]
         @data=[]
         for i in 0..239
            @data << [i,i,220,[0,1,2,3,4,220,6]]
          end
          options={:image_width=>(size.width-SPAN_WIDTH),:image_height=>(size.height-10),:need_title=>true}
          rc=StockChart::RealTimeChart.new(dc,@data,options)
          rc.draw()
        end
      end
    end #end class
    
    
    ##
    #日线面板
    class RealTimePane < Wx::Panel
      ##
      #初始化
      def initialize(parent)
        super(parent)
        @real = RealTimeStockWindow.new(self)
        evt_size { | e | on_size(e) }
      end
      
      ##
      #重画
      def on_size(evt)
        #产生设置
        win_width=evt.size.width
        win_height=evt.size.height
        #RE SIZE
        @real.size = Wx::Size.new(win_width.to_i, win_height.to_i)
        @real.refresh
      end
    end#end class 
   
  end
  
end

# Create our Animation Timer
##@timer = Wx::Timer.new(self,1000)
# gui controls.
##@timer.start(25)
# Setup the event Handler to do the drawing on this window.
##evt_timer 1000, :animate

