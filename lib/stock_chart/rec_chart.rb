

module StockChart
  
  ##
  #实时股票绘图
  class RecChart 
  
    ##
    #常量定义
    WIDTH=20
    HEIGHT=20
    ##
    #初始化
    #per={1-0}
    def initialize(gc,per=0.5,options={})
      @per=per
      #图片大小
      @image_width=options[:image_width].nil? ? WIDTH : options[:image_width]
      @image_height=options[:image_height].nil? ? HEIGHT : options[:image_height]
      @hmid=0
      @vmid=0
      
      @gc = gc
    end
    

    ##
    #画数据
    #data=draw.polyline(x1, y1,...,xN, yN) -> draw
    #[[x,y,values],...]
    def draw()
      
      for x in 1..3
        for y in 1..3
          if (x+y) < @per
            @gc.set_brush(Wx::GREEN_BRUSH)
            @gc.set_pen(Wx::GREEN_PEN)
          else
            @gc.set_brush(Wx::RED_BRUSH)
            @gc.set_pen(Wx::RED_PEN)
          end

          @gc.draw_rectangle(x*WIDTH-2,y*HEIGHT-2,WIDTH,HEIGHT)
          
        end
        
      end
    end
  
    ##
    #获得当前数据的frame上下沿数据
    #now_data=[[x,y,[code,name,trade_money,trade_amount,current_price,last_price,start_price,zt_radar]],...]
    def grid_data(data)
      super(data)
    end
    
  end
end