module StockChart
  
  ##
  #实时股票绘图
  class RealTimeChart < Chart
  
    ##
    #初始化
    def initialize(gc,data=[],options={})
      super(gc,data,options)
    end
    
    ##
    #绘制股票图片
    def draw(data=nil)      
      #画边框
      super(data)
    end
  
    ##
    #画框架
    #data=[最高，高中，开盘，中线，底线]
    def draw_grid(data)
      
      @gc.set_brush(Wx::BLACK_BRUSH)
      @gc.draw_rectangle(@x,@y,@plot_width,@plot_height)
      @gc.set_brush(Wx::WHITE_BRUSH)
      @gc.set_pen(Wx::MEDIUM_GREY_PEN)
      
      #这里是四个区间
      ## y
      #顶线
      for i in 0..@ytick
        y=@y+@yaxis.ticksize*i
        @gc.draw_text(data[i].to_s,0,y.to_i)
        @gc.draw_line(@x.to_i,y.to_i,@plot_x.to_i,y.to_i)
      end
      ## x
      #顶线
      y=@plot_y+10
      @gc.draw_text("9:30",X.to_i,y.to_i)
      @gc.draw_text("11:30",(@xaxis.ticksize*2).to_i,y.to_i)
      @gc.draw_text("15:00",(@xaxis.ticksize*4).to_i,y.to_i)
      xmid=(@xtick.to_f/2).round.to_i
      for i in 1..@xtick
        x=@x+@xaxis.ticksize*i
        @gc.draw_line(x.to_i,@y.to_i,x.to_i,@plot_y.to_i)
      end
      
    end
  

    ##
    #画数据
    #data=draw.polyline(x1, y1,...,xN, yN) -> draw
    #[[x,y,[code,name,trade_money,trade_amount,current_price,last_price,start_price,zt_radar]],...]
    def draw_data(data)
      poly_line=[]
      for d in data
        poly_line << [@xaxis.hoz(d[0]).to_i, @yaxis.vert(d[1]).to_i]
      end
      
      @gc.set_brush(Wx::WHITE_BRUSH)
      p = Wx::Pen.new("#234390",2,Wx::SOLID)
      @gc.set_pen(p)
      
      @gc.draw_lines(poly_line) #-> draw 
    end
    
    ##
    #获得当前数据的frame上下沿数据
    #now_data=[[x,y,[code,name,trade_money,trade_amount,current_price,last_price,start_price,zt_radar]],...]
    def grid_data(data)
      idata=data[0] 
      @last_price=idata[2]
      [@yaxis.max,(@yaxis.max+@last_price)/2,@last_price,(@yaxis.min+@last_price)/2,@yaxis.min]
    end
    
    ##
    #从新计算x,y
    def re_draw(data)
      #re draw
      @data=data
      @xaxis=Xaxis.new(@data, (@plot_x.to_f)/@xtick,@plot_width,@x)
      @yaxis=Yaxis.new(@data, (@plot_y.to_f).to_f/@ytick,@y,@plot_height,@data[0][2])
    end
    
  end
  
end