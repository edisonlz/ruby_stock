

module StockChart
  
  ##
  #加载坐标
  #include PlotAxis
  
  ##
  #实时股票绘图
  class Chart
  
    ##
    #引用定义
    #include Magick    
  
    ##
    #属性定义
    attr_reader  :code_image,:image_width,:image_height
  
    ## 
    #常量定义
    X = 20   #起始X
    Y = 10   #起始Y
    TITLE_HEIHGT=30
    LEFT_SPAN=10
    BOTTOM_SPAN=15
    OUT_WIDTH=340
    OUT_HEIGHT=215
    WIDTH=340 #图片默认大小 200px × 130px 
    HEIGHT=215 #图片默认大小
    XRANGE=4 #data sampling point
    YRANGE=4
    CODE_TAG="上证指数[000001]"
    
    ##
    #初始化
    #data= [x,y,last_price,value],...]
    def initialize(gc,data=[],options={})
      ##
      #读取数据
      @data=data
      #边框开始x，y
      @x=options[:x].nil? ? X : options[:x]
      @y=options[:y].nil? ? Y : options[:y]

      #图片大小
      @image_width=options[:image_width].nil? ? WIDTH : options[:image_width]
      @image_height=options[:image_height].nil? ? HEIGHT : options[:image_height]
     
      #Code Tag
      @code_tag=options[:code_tag].nil? ? CODE_TAG : options[:code_tag]
      @code_date=options[:code_date].nil? ? Time.now.strftime("%Y-%m-%d") : options[:code_date]
      
      #边框的大小
      @plot_width=@image_width-LEFT_SPAN
      @plot_height=@image_height-BOTTOM_SPAN
      @plot_y=@plot_height+@y
      @plot_x=@plot_width+@x
      
      @need_title=options[:need_title].nil? ? false : options[:need_title]
      @title_height=0
      if @need_title==true
        @plot_height-=TITLE_HEIHGT
        @y+=TITLE_HEIHGT
      end
      ##
      #tick_size
      @xtick=options[:xtick].nil? ? XRANGE : options[:xtick]
      @ytick=options[:ytick].nil? ? YRANGE : options[:ytick]
      
    
      ##
      #initialize axis
      re_draw(@data)
      
      #style
      @bgcolor=options[:bgcolor].nil? ? "white" : options[:bgcolor]
      @line_bordor_color=options[:line_bordor_color].nil? ? "#000000" : options[:line_bordor_color]
      @line_color=options[:line_color].nil? ? "#000000" : options[:line_color]
      
      @gc=gc
      @gc.set_text_foreground(Wx::WHITE)
      
    end
  
    ##
    #绘制股票图片
    def draw(data=nil)
      #画边框
      unless data.nil?
        re_draw(data)
      end
      
      if @need_title
        draw_title
      end
      
      data = @data 
      draw_grid(grid_data(data))
      #画数据
      draw_data(data)
    end
    
    ##
    # 画标题
    def draw_title
      #idata=@data[0][3]
      #@gc.draw_text(idata.to_s,0,0)
    end
    
    ##
    #画框架
    #data=[最高，高中，开盘，中线，底线]
    def draw_grid(data)
      @gc.set_text_foreground(Wx::WHITE)
      xdata,ydata=data

      
      @gc.set_brush(Wx::BLACK_BRUSH)
      @gc.draw_rectangle(@x.to_i,@y.to_i,@plot_width.to_i,@plot_height.to_i)
      
      @gc.set_brush(Wx::WHITE_BRUSH)
      @gc.set_pen(Wx::MEDIUM_GREY_PEN)      

      ## y
      #顶线
      for i in 0..@ytick
        y=@y+@yaxis.ticksize*i
        @gc.draw_text(ydata[i].to_s,0,y.to_i)
        @gc.draw_line(@x.to_i,y.to_i,@plot_x.to_i,y.to_i)
      end
      
      ## x
      #顶线
      y=@plot_y
      xmid=(@xtick.to_f/2).round.to_i
      for i in 0..@xtick
        x=@x+@xaxis.ticksize*i
        @gc.draw_line(x.to_i,@y.to_i,x.to_i,@plot_y.to_i)
        @gc.draw_text(xdata[i].to_s,x.to_i,y.to_i)
      end
      
    end
  

    ##
    #画数据
    #data=draw.polyline(x1, y1,...,xN, yN) -> draw
    #[[x,y,[code,name,trade_money,trade_amount,current_price,last_price,start_price,zt_radar]],...]
    def draw_data(data)
    
    end
    
    ##
    #获得当前数据的frame上下沿数据
    #now_data=[[x,y,last_price,[code,name,trade_money,trade_amount,current_price,last_price,start_price,zt_radar]],...]
    def grid_data(data)
      ylist=[]
      xlist=[]
      yspan=(data.size.to_f/@ytick.to_f).to_i
      for i in 0..@ytick
        index=i*yspan
        index-=1 if index>0        
        if index.to_i < data.size
          idata=data[index.to_i]
          ylist << idata[1]
        end
      end
      xspan=(data.size.to_f/@xtick.to_f).to_i
      for i in 0..@xtick
        index=i*xspan
        index-=1 if index>0
        if index.to_i < data.size
          xlist << data[index.to_i][0]
        end
      end
      ylist.reverse!
      [xlist,ylist]
    end
    
    ##
    #从新计算x,y
    def re_draw(data)
      #re draw
      @data=data
      @xaxis=Xaxis.new(@data, (@plot_width.to_f)/@xtick,@plot_width,@x)
      @yaxis=Yaxis.new(@data, (@plot_height.to_f)/@ytick,@y,@plot_height)
    end
    
  end
  
end