module StockChart
  
  ##
  #坐标轴
  class Axis
    ##
    #属性定义
    attr_accessor :min,:max,:ticksize
    
    ##
    #初始化
    #data=[[x,y,values],......]
    #axis={0=>x,1=>y}
    def initialize(data,axis,ticksize)
      @min=100000000
      @max=-100000000
      @ticksize=ticksize
      calc(data,axis)
    end
    
    ##
    #计算最大值，最小值
    def calc(data,axis)
      for d in data
        if @min.to_f > d[axis].to_f
          @min=d[axis]
        end
        if @max.to_f<d[axis].to_f
          @max=d[axis]
        end
      end
    end
    
  end
  
  ##
  #X坐标轴
  class Xaxis < Axis
    
    ##
    #属性定义
    attr_accessor :hozscale,:plot_width,:span
    
    ##
    #初始化
    def initialize(data,ticksize,plot_width,span)
      @plot_width=plot_width
      @span=span
      super(data,0,ticksize)
      #水平坐标，到每个点的距离
      @hozscale = (@plot_width.to_f-0) / (@max-@min+1)
    end
    
    ##
    #计算x轴坐标
    def hoz(x)
      return (x - @min) * @hozscale+@span;
    end
  
    
  end
  
  ##
  #Y坐标轴
  class Yaxis < Axis
    
    ##
    #属性定义
    attr_accessor :vertscale,:last_value,:plot_height
    
    ##
    #初始化
    def initialize(data,ticksize,span,plot_height,last_value=false,max=nil,min=nil)
      super(data,1,ticksize)
      @plot_height=plot_height
      @last_price=last_value
      @pan=span
      @span=@plot_height.to_f
      unless max.nil?
        @max=max
      end
       unless min.nil?
        @min=min
      end
      if(@last_price==false)
        #标准坐标比例
        @vertscale = (@span).to_f / (@max - @min+1)
      else
        range_calc()
      end
    end
    
    ##
    #y轴最大值
    def max(default=false)
      if @last_value==false or default
        return @max
      else
        return @y_max
      end
    end
    
    ##
    #y轴最小值
    def min(default=false)
      if @last_value==false or default
        return @min
      else
        return @y_min
      end
    end
    
    ##
    #计算y轴坐标
    def vert(y)
      #puts y if y<10.77
      @pan + @span - (y - @min) * @vertscale
    end
    
    private
    ##
    #计算坐标轴的值,按照最大的比例计算
    #从last_value基线画起
    def range_calc()
      max_per=(1-@max.to_f/@last_price.to_f).abs
      min_per= (1-@min.to_f/@last_price.to_f).abs
      @per_range= max_per.to_f > min_per.to_f ? max_per : min_per
      
      @y_max=@last_price+@last_price*@per_range
      @y_min=@last_price-@last_price*@per_range
      
      @vertscale = @plot_height.to_f / (@y_max - @y_min)
      
    end
    
  end 
  
end