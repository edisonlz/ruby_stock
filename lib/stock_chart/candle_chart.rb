

module StockChart
  
  ##
  #实时股票绘图
  class CandleChart < Chart
  
    ##
    #初始化
    #数据格式是[x,最高，最低，开，收]
    def initialize(gc,data=[],options={})
      super(gc,data,options)
      #puts "initial CandleChart ok "
      @gc.set_background(Wx::BLACK_BRUSH)
    end
    
    ##
    #绘制股票图片
    #数据格式是[x,最高，最低，开，收]
    def draw(data=nil)      
      #画边框
      super(data)         
    end
  
    ##
    #画框架
    #数据格式是[x,最高，最低，开，收]
    def draw_grid(data)
      super(data)
    end

    ##
    #画数据
    #data=draw.polyline(x1, y1,...,xN, yN) -> draw
    #数据格式是[x,最高，最低，开，收]
    def draw_data(data)
      poly_line=[]
      for d in data
        poly_line << [@xaxis.hoz(d[0]),@yaxis.vert(d[1]),@yaxis.vert(d[2]),@yaxis.vert(d[3]),@yaxis.vert(d[4])]
      end
     
      icount=0
      for p in poly_line
        if p[3]<=p[4]
          @gc.set_brush(Wx::GREEN_BRUSH)
          @gc.set_pen(Wx::GREEN_PEN)
          h=(p[4]-p[3])
          h=1 if h.to_i==0 
          @gc.draw_rectangle((p[0]).to_i,p[3].to_i,(@xaxis.hozscale-1).to_i,h.to_i)
        else
          @gc.set_brush(Wx::RED_BRUSH)
          @gc.set_pen(Wx::RED_PEN)
          h=(p[3]-p[4])
          h=1 if h.to_i==0 
          @gc.draw_rectangle((p[0]).to_i,p[4].to_i,(@xaxis.hozscale-1).to_i,h.to_i)
        end
        #画最高，最低
        x=(p[0]-1+@xaxis.hozscale.to_f/2)
        @gc.draw_line(x.to_i,p[1].to_i,x.to_i,p[2].to_i)
        
        #画开盘收盘
       
        icount+=1
      end
      @gc.set_brush(Wx::NULL_BRUSH)
    end 
  
    ##
    #获得当前数据的frame上下沿数据
    #数据格式是[最高，最低，开，收]
    def grid_data(data)
      super(data)
    end
    
    ##
    #从新计算x,y
    def re_draw(data)
      #re draw
      @data=data
      calc_range(data)
      @xaxis=Xaxis.new(@data, (@plot_width.to_f)/@xtick,@plot_width,@x)
      @yaxis=Yaxis.new(@data, (@plot_height.to_f)/@ytick,@y,@plot_height,false,@max,@min)
    end
    
    ##
    # 画标题
    def draw_title
      @gc.set_text_foreground(Wx::Colour.new("#FFFF66"))
      idata=@data[0][5]
      name=@data[0][6]
      @gc.draw_text(name,10,0)
      @gc.draw_text(idata.code.to_s,10,15)
      @gc.draw_text("开盘#{idata.open}",100,15)
      @gc.draw_text("最低#{idata.low}",180,15)
      @gc.draw_text("最高#{idata.high}",260,15)
      @gc.draw_text("收盘#{idata.close}",340,15)
      @gc.draw_text("成交量#{idata.volume}",420,15)
      
    end
    
    private
    #计算max min
    def calc_range(data)
      @min=10000
      @max=0
      for d in data
        if @min.to_f > d[2].to_f
          @min=d[2]
        end
        if @max.to_f<d[1].to_f
          @max=d[1]
        end
      end
      #puts "#{@max},#{@min}"
    end
    
  end
  
end