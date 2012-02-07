module Utility
  
  module WindowDayStock
   
    ##
    # 日线
    class DayStockWindow < Wx::Window
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
        evt_key_down {|evt|on_key_down(evt.get_key_code) }
      end
      
      ##
      #keydown 显示股票代码提示框
      def on_key_down(key)
       
        case key.to_i
        when 48..57
          choices=[]
          for i in 1..100
            choices << (600000+i).to_s
          end
          dialog = Wx::SingleChoiceDialog.new(self,
            "股票代碼",
            "請選擇",
            choices, Wx::OK | Wx::CANCEL)

          dialog.set_selection(2)
          if dialog.show_modal() == Wx::ID_OK
            #puts dialog.get_string_selection()
            self.parent.parent.parent.parent.stock_refresh(dialog.get_string_selection())
          end
        when Wx::K_UP
          #获得更多的数据
          
        when Wx::K_DOWN
          #减少显示数据

        end
      end
      ##
      #To Draw
      def on_paint(evt)
        ##
        #draw window context
        paint do |dc|
          #[x,最高，最低，开，收
          @data=[]
          index=$PREFS[:dat].size
          for i in $PREFS[:dat]
            @data << [index,i.high,i.low,i.open,i.close,i,$PREFS[:stand].name]
            index-=1
          end
          options={:image_width=>(size.width-SPAN_WIDTH),:image_height=>(size.height-8),:need_title=>true}
          rc=StockChart::CandleChart.new(dc,@data,options)
          rc.draw()
        end
      end
    end #end class
    
    ##
    # 成交量
    class TradeVolumeWindow < Wx::Window
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
        #puts size.height
        ##
        #draw window context
        #size = get_client_size
        paint do |dc|
          #[x,最高，最低，开，收]
          @data=[]
          index=$PREFS[:dat].size
          for i in $PREFS[:dat]
            @data << [index,i.volume,i.open,i.close,i]
            index-=1
          end
          options={:image_width=>(size.width-SPAN_WIDTH),:image_height=>(size.height-2)}
          rc=StockChart::BarChart.new(dc,@data,options)
          rc.draw()
        end
      end
    end #end class
    
    
    ##
    #日线面板
    class DayListPane < Wx::Panel
      ##
      #初始化
      def initialize(parent)
        super(parent)
        @win = DayStockWindow.new(self)
        evt_size { | e | on_size(e) }
      end
      
      ##
      #重画
      def on_size(evt)
        #产生设置
        win_width=evt.size.width
        win_height=evt.size.height
        #RE SIZE
        @win.size = Wx::Size.new(win_width.to_i, win_height.to_i)
        @win.refresh
      end
      
    end#end class
    
    ##
    #日线面板
    class VolumePane < Wx::Panel
      
      ##
      #初始化
      def initialize(parent)
        super(parent)
        @volume = TradeVolumeWindow.new(self)
        evt_size { | e | on_size(e) }
      end
      
      ##
      #重画
      def on_size(evt)
        #产生设置
        vol_width=evt.size.width
        vol_height=evt.size.height
        #RE SIZE
        @volume.size=Wx::Size.new(vol_width.to_i, vol_height.to_i)
        @volume.refresh        
      end
    end#end class
    
    class DayPanel < Wx::Panel
      ##
      #初始化
      def initialize(parent)
        super(parent)
        sizer = Wx::BoxSizer.new(Wx::VERTICAL)
        @d=DayListPane.new(self)
        sizer.add(@d, 3,Wx::GROW|Wx::ALL|Wx::ALIGN_TOP, 4)
        @v=VolumePane.new(self)
        sizer.add(@v, 1,Wx::GROW|Wx::ALL|Wx::ALIGN_TOP, 4)
        self.sizer = sizer
      end
    end
    
  end
  
end

# Create our Animation Timer
##@timer = Wx::Timer.new(self,1000)
# gui controls.
##@timer.start(25)
# Setup the event Handler to do the drawing on this window.
##evt_timer 1000, :animate

