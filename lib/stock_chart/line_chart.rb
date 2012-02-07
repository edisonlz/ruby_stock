module StockChart
  
  ##
  #实时股票绘图
  class LineChart < Chart
    
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
    #[[x,y,[code,name,trade_money,trade_amount,current_price,last_price,start_price,zt_radar]],...]
    def draw_data(data)
      poly_line=[]
      for d in data
        poly_line << [@xaxis.hoz(d[0]), @yaxis.vert(d[1])]
      end
      #@gc.translate(@x, @y)
      @gc.draw_lines(*poly_line) #-> draw 
    end
  
    ##
    #获得当前数据的frame上下沿数据
    #now_data=[[x,y,[code,name,trade_money,trade_amount,current_price,last_price,start_price,zt_radar]],...]
    def grid_data(data)
      super(data)
    end
    
  end
end