
module Utility
  
  module StockIndex
    
    class StockIndexPane < Wx::Panel
      ##
      #初始化
      #stardar 传入股票标准信息
      def initialize(parent)
        super(parent)
        draw_index()
        #evt_size { | e | on_size(e) }
      end
      
      ##
      #绘制指标参数
      def draw_index()    
        standard=$PREFS[:stand]
        #set @sizer
        @sizer = Wx::BoxSizer.new(Wx::VERTICAL)
          
        @m_text=create_static_text(self, "\n 代码: #{standard.symbol.to_s} \n" )
        @sizer.add(@m_text)
        @m_text=create_static_text(self," 名称: #{standard.name.to_s} \n"  )
        @sizer.add(@m_text)
        @m_text=create_static_text(self, " 上个交易: #{standard.lastTrade.to_s} \n" )
        @sizer.add(@m_text)
        @m_text=create_static_text(self, " 日期: #{standard.date.to_s} \n" )
        @sizer.add(@m_text)
        @m_text=create_static_text(self, " 时间: #{standard.time.to_s} \n" )
        @sizer.add(@m_text)
        @m_text=create_static_text(self, " 换手: #{standard.change.to_s} \n" )
        @sizer.add(@m_text)
        @m_text=create_static_text(self, " 换手比: #{standard.changePoints.to_s} \n" )
        @sizer.add(@m_text)
        @m_text=create_static_text(self, " 前收盘: #{standard.previousClose.to_s} \n" )
        @sizer.add(@m_text)
        @m_text=create_static_text(self," 开盘价: #{standard.open.to_s} \n" )
        @sizer.add(@m_text)
        @m_text=create_static_text(self, " 收盘价: #{standard.dayHigh.to_s} \n" )
        @sizer.add(@m_text)
        @m_text=create_static_text(self, " 最低: #{standard.dayLow.to_s} \n" )
        @sizer.add(@m_text)
        @m_text=create_static_text(self, " 成交量: #{standard.volume.to_s} \n" )
        @sizer.add(@m_text)
        @m_text=create_static_text(self," 日幅度: #{standard.dayRange.to_s} \n" )
        @sizer.add(@m_text)
        #        @m_text=create_static_text(self, " 上个交易时间: #{standard.lastTradeWithTime.to_s} \n" )
        #        @sizer.add(@m_text)
        #        @m_text=create_static_text(self, " 趋势: #{standard.tickerTrend.to_s} \n" )
        #        @sizer.add(@m_text)
        @m_text=create_static_text(self, " 平均成交量: #{standard.averageDailyVolume.to_s} \n" )
        @sizer.add(@m_text)
        @m_text=create_static_text(self, " 竞价: #{standard.bid.to_s} \n" )
        @sizer.add(@m_text)
        @m_text=create_static_text(self," 询价: #{standard.ask.to_s} \n" )
        @sizer.add(@m_text)
        
        #set index
        #        @m_gauge = Wx::Gauge.new( self, -1, 100, Wx::Point.new(18,50), Wx::Size.new(155, 20), Wx::GA_HORIZONTAL|Wx::NO_BORDER )
        #        @m_gauge.set_background_colour(Wx::GREEN)
        #        @m_gauge.set_foreground_colour(Wx::RED)
        #        @m_gauge.set_value( 36 )
        #        @sizer.add(@m_gauge)
   
        self.sizer=@sizer
       
      end
      
      ##
      #刷新股票信息
      def enter_stock(standard)
        #self.refresh
        draw_index(standard)
        #self.refresh
      end
      
      def create_static_text(panel,text,color=Wx::BLUE)
        m_label = Wx::StaticText.new(panel, -1, text,
          Wx::Point.new(250, 60),  Wx::DEFAULT_SIZE,
          Wx::ALIGN_RIGHT)
        m_label.set_foreground_colour(color)
        m_label
      end
      
      ##
      #重画
      def on_size(evt)
        #产生设置
#        win_width=evt.size.width
#        win_height=evt.size.height
#        #RE SIZE
#        self.size = Wx::Size.new(win_width.to_i, win_height.to_i)
#        self.refresh
      end
   
    end#end class 
   
  end
  
end

#        @m_slider = Slider.new( self, ID_SLIDER, 0, 0, 200, Point.new(18,90), Size.new(155,-1),
#          SL_AUTOTICKS | SL_LABELS )
#        @m_slider.set_tick_freq(40, 0)
#        @m_slider.set_tool_tip("This is a sliding slider")