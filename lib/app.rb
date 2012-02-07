##
# Reqiure 区域 do

require 'chred/chred_prefs'
require 'chred/load_requires'
#初始化数据
$PREFS = CHRED.init_prefs
CHRED.init_mongoose_db()

# 设置参数
$PREFS[:date_Index]=CHRED::DEFAULTSHOWCOUNT
$PREFS[:endDate]= Date.today()
$PREFS[:startDate]=Date.today() - $PREFS[:date_Index]
$PREFS[:code]=CHRED.format
$PREFS[:dat]= CHRED.get_list($PREFS[:code],$PREFS[:startDate],$PREFS[:endDate])
$PREFS[:stand] = CHRED.get_stand($PREFS[:code])
#$PREFS[:extend] = CHRED.get_extend($PREFS[:code])

begin
  require 'rubygems'
rescue LoadError
end

require 'wx'
require 'stock_chart/chart_config'
require 'utility/util_config'

# end

##
# include 区域 do
include Utility::WindowDayStock
include Utility::WindowRealTime
include Utility::WindowPie
include Utility::StockIndex
# end


##
# 代码区 do
class StockFrame < Wx::Frame
 
  ##
  #初始化
  def initialize(*args)
    super
    @mgr = Wx::AuiManager.new
    @mgr.set_managed_window(self)
    self.set_background_colour(Wx::BLACK)
    @perspectives = []
    
    @notebook_style = Wx::AUI_NB_DEFAULT_STYLE|Wx::AUI_NB_TAB_EXTERNAL_MOVE|Wx::NO_BORDER
    @notebook_theme = 0
    
    setup_panes
    setup_perspectives

    #self.evt_key_down {|evt| on_key_down(evt.get_key_code) }
    
    @mgr.update
    
  end

  ##
  #建立panels
  def setup_panes
    
    pi = Wx::AuiPaneInfo.new
    pi.set_name('stock_info').set_caption('股票分析 - 扩展指标').left
    #pi.set_layer(1).set_position(1).set_close_button.set_maximize_button
    pi.set_layer(1).set_position(1).set_maximize_button
    @stock_index = StockIndexPane.new(self)
    #@mgr.add_pane(create_tree_ctrl, pi)
    @stock_index.set_size(180,size.height)
    @mgr.add_pane(@stock_index, pi)

    wnd10=PiePane.new(self)
    wnd10.set_size(size.width,100)
    pi = Wx::AuiPaneInfo.new
    pi.set_name('stock_pie').set_caption('股票分析 - 盘面分析')
    pi.bottom.set_layer(1).set_position(1)
    @mgr.add_pane(wnd10, pi)
    
    # create some center panes
    pi = Wx::AuiPaneInfo.new
    pi.set_name('stockline').center_pane.hide
    @mgr.add_pane(create_notebook, pi)
    
  end
 
  #侦听 panels
  def setup_perspectives
    perspective_all = @mgr.save_perspective

    @mgr.each_pane do | pane | 
      pane.hide unless pane.is_toolbar
    end

    #定义默认显示的panel do
    @mgr.get_pane("stock_info").show.right.set_layer(0).set_row(0).set_position(0)
    @mgr.get_pane("stock_pie").show.bottom.set_layer(0).set_row(0).set_position(0)
    @mgr.get_pane("stockline").show()
    #end 
    perspective_default = @mgr.save_perspective
  
    @perspectives << perspective_default
    @perspectives << perspective_all
  end


  ##
  #添加事件
  include Utility::Events
  ##
  #添加控件
  include Utility::Controls
  
end

##
#应用程序App
class HiWorldApp < Wx::App
  ##
  #初始化
  def on_init
    frame = StockFrame.new( nil, Wx::ID_ANY, "3Z 股票分析软件",
      Wx::DEFAULT_POSITION,
      Wx::Size.new(1024, 768) )
    set_top_window(frame)
    frame.show
    return true
  end
end

##
#开始侦听应用程序
HiWorldApp.new.main_loop()

# end 