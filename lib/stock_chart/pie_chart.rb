module StockChart
  
  class PieChart
    
    ##
    #常量定义
    SPAN=5
    ##
    #属性定义
    attr_reader  :image_width,:image_height,:per
    
    ##
    #常量定义
    WIDTH=200
    HEIGHT=200
    ##
    #初始化
    #per={1-0}
    def initialize(gc,per=0.5,options={})
      @per=per
      #图片大小
      @image_width=options[:image_width].nil? ? WIDTH : options[:image_width]
      @image_height=options[:image_height].nil? ? HEIGHT : options[:image_height]
      @hmid=SPAN
      @vmid=SPAN
      
      @gc = gc
    end
    
    ##
    #draw pie
    def draw()
      iend=360*@per
      @gc.set_brush(Wx::RED_BRUSH)
      @gc.set_pen(Wx::RED_PEN)
      @gc.draw_elliptic_arc(@hmid,@vmid,@image_height,@image_height,0,iend)
      @gc.set_brush(Wx::BLUE_BRUSH)
      p = Wx::Pen.new("#0000ff",2,Wx::SOLID)
      @gc.set_pen(p)
      @gc.draw_elliptic_arc(@hmid,@vmid,@image_height,@image_height,iend,360)
      
      @gc.draw_text("#{(@per*10).round}:#{(10-(@per*10).round).to_i}",@image_height/2-5,@image_height/2-5)
    end
    
  end
  
end