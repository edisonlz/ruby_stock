module Utility
  
  module WindowPie
    ##
    # 日线
    class PieStockWindow < Wx::Window
      SPAN_WIDTH=15
      ##
      #初始化
      def initialize(parent,per=0.5)
        super(parent)
        # Create the font we'll use to create our pre-defined fonts for the painting
        @font = Wx::Font.new(15,Wx::FONTFAMILY_TELETYPE,Wx::FONTSTYLE_NORMAL,Wx::FONTWEIGHT_NORMAL)
        @per=per
        evt_paint :on_paint
      end
      ##
      #To Draw
      def on_paint(evt)
        ##
        #draw window context
        paint do |dc|
          #[x,最高，最低，开，收]
          options={:image_width=>(size.height-10),:image_height=>(size.height-10)}
          rc=StockChart::PieChart.new(dc,@per,options)
          rc.draw()
        end
        
      end
    end #end class
    
    
    ##
    # 日线
    class RecStockWindow < Wx::Window
      SPAN_WIDTH=15
      ##
      #初始化
      def initialize(parent,per=0.5)
        super(parent)
        # Create the font we'll use to create our pre-defined fonts for the painting
        @font = Wx::Font.new(15,Wx::FONTFAMILY_TELETYPE,Wx::FONTSTYLE_NORMAL,Wx::FONTWEIGHT_NORMAL)
        @per=per
        evt_paint :on_paint
      end
      ##
      #To Draw
      def on_paint(evt)
        ##
        #draw window context
        paint do |dc|
          #[x,最高，最低，开，收]
          options={:image_width=>(size.height-10),:image_height=>(size.height-10)}
          rc=StockChart::RecChart.new(dc,@per,options)
          rc.draw()
        end
        
      end
    end #end class
    
    
    class LiePane < Wx::Panel
      ##
      #初始化
      def initialize(parent,per=0.5)
        super(parent)
        sizer = Wx::BoxSizer.new(Wx::HORIZONTAL)
        @pie1 = PieStockWindow.new(self,per)
        sizer.add(@pie1, 0,Wx::GROW|Wx::ALL|Wx::ALIGN_TOP, 4)
        self.sizer=sizer
        evt_size { | e | on_size(e) }
      end
      
      ##
      #重画
      def on_size(evt)
        #产生设置
        win_width=evt.size.width
        win_height=evt.size.height
        #RE SIZE
        @pie1.size = Wx::Size.new(win_width.to_i, win_height.to_i)
        @pie1.refresh
      end
    end#end class 
    
    
    
    
    class PiePane < Wx::Panel
      ##
      #初始化
      def initialize(parent)
        super(parent)
        sizer = Wx::BoxSizer.new(Wx::HORIZONTAL)
        @pie = LiePane.new(self)
        @pie.set_size(100,size.height)
        sizer.add(@pie, 0,Wx::GROW|Wx::ALL|Wx::ALIGN_TOP, 4)
        
        @pie1 = LiePane.new(self,0.4)
        @pie1.set_size(100,size.height)
        sizer.add(@pie1, 0,Wx::GROW|Wx::ALL|Wx::ALIGN_TOP, 4)
        
        @pie2 = LiePane.new(self,0.3)
        @pie2.set_size(100,size.height)
        sizer.add(@pie2, 0,Wx::GROW|Wx::ALL|Wx::ALIGN_TOP, 4)
        
        @pie3 = LiePane.new(self,0.2)
        @pie3.set_size(100,size.height)
        sizer.add(@pie3, 0,Wx::GROW|Wx::ALL|Wx::ALIGN_TOP, 4)
        
        @rec=RecStockWindow.new(self,5)
        @rec.set_size(100,size.height)
        sizer.add(@rec, 0,Wx::GROW|Wx::ALL|Wx::ALIGN_TOP, 4)
        
        @rec=RecStockWindow.new(self,5)
        @rec.set_size(100,size.height)
        sizer.add(@rec, 0,Wx::GROW|Wx::ALL|Wx::ALIGN_TOP, 4)
        
        self.sizer=sizer
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

