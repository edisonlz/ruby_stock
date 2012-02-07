

module StockChart
  
  ##
  #实时股票绘图
  class BarChart < Chart
  
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
      super(data)
    end

    ##
    #画数据
    #data=draw.polyline(x1, y1,...,xN, yN) -> draw
    #[[x,y,values],...]
    def draw_data(data)
      poly_line=[]
      for d in data
        poly_line << [@xaxis.hoz(d[0]),@yaxis.vert(d[1]),d[2],d[3]]
      end
      #@gc.translate(@x, @y)
      icount=0
      for p in poly_line
        if p[2].to_f>p[3].to_f
          @gc.set_brush(Wx::GREEN_BRUSH)
          @gc.set_pen(Wx::GREEN_PEN)
        else
          @gc.set_brush(Wx::RED_BRUSH)
          @gc.set_pen(Wx::RED_PEN)
        end
        @gc.draw_rectangle(p[0].to_i,p[1].to_i,@xaxis.hozscale.to_i-1,(@plot_y-p[1]).to_i)
        icount+=1
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