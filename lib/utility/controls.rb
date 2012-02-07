module Utility
  module Controls
  
    def create_static_text(panel,text,color=Wx::BLUE)
      m_label = StaticText.new(panel, -1, text,
        Point.new(250, 60), DEFAULT_SIZE,
        ALIGN_RIGHT)
      m_label.set_foreground_colour(color)
      m_label
    end
    
    def create_text_ctrl(text = "")
      if text.empty?
        text = "This is a test text box"
      end
      Wx::TextCtrl.new( self, Wx::ID_ANY, text, 
        Wx::Point.new(0, 0), Wx::Size.new(150, 90),
        Wx::NO_BORDER|Wx::TE_MULTILINE)
    end
  
    def create_grid
      grid = Wx::Grid.new(self, Wx::ID_ANY,
        Wx::Point.new(0, 0),
        Wx::Size.new(150, 250),
        Wx::NO_BORDER|Wx::WANTS_CHARS)
      grid.create_grid(50, 20)
      grid
    end


    def create_tree_ctrl
      tree  = Wx::TreeCtrl.new( self, Wx::ID_ANY,
        Wx::Point.new(0, 0), Wx::Size.new(160, 250),
        Wx::TR_DEFAULT_STYLE|Wx::NO_BORDER)

      img_list = Wx::ImageList.new(16, 16, true, 2)
      img_list.add( Wx::ArtProvider::get_bitmap( Wx::ART_FOLDER, 
          Wx::ART_OTHER, 
          Wx::Size.new(16, 16) ) )
      img_list.add( Wx::ArtProvider::get_bitmap( Wx::ART_NORMAL_FILE, 
          Wx::ART_OTHER, 
          Wx::Size.new(16, 16) ) )
      tree.set_image_list(img_list)
      root = tree.add_root("板块分类", 0)
      items = []
      1.upto(5) { | i | items << tree.append_item(root, "分类 #{i}", 0) }
    
      items.each do | id |
        1.upto(5) { | i | tree.append_item(id, "子分类 #{i}", 0) }
      end

      tree.expand(root)
      tree
    end

    def create_size_report_ctrl(width = 80, height = 80)
      SizeReportCtrl.new( self, Wx::ID_ANY,
        Wx::DEFAULT_POSITION,
        Wx::Size.new(width, height), @mgr )
    end
    
    
    def create_html_ctrl(parent = nil,data=nil)
      if not parent
        parent = self
      end
      ctrl = Wx::HtmlWindow.new(parent, Wx::ID_ANY,
        Wx::DEFAULT_POSITION,
        Wx::Size.new(400, 300) )
      if data.nil?
        ctrl.set_page("<div>
                      <div align=center>
                        <h2>3Z版本股票软件 - 说明</h2>
                      </div>
                      <div  style='width:200px'>
                        <div>该软件提供了基本的数据采集，对数据进行加工和分析.</div>
     <div> 该软件本着绿色和免费的宗旨，为光大股民提供一个免费的看盘平台.</div>
     <div>作者:Liuzheng</div>
    <div> 联系信箱: edisonlz1@163.com</div>
                      </div></div>")
      else
        ctrl.set_page(data)
      end
      ctrl
    end

    def create_notebook
      # create the notebook off-window to avoid flicker
      client_size = get_client_size

      ctrl = Wx::AuiNotebook.new( self, Wx::ID_ANY,
        Wx::Point.new(client_size.x, client_size.y),
        Wx::Size.new(430, 200),
        @notebook_style)
    
      page_bmp = Wx::ArtProvider::get_bitmap( Wx::ART_NORMAL_FILE, 
        Wx::ART_OTHER, 
        Wx::Size.new(16,16) )
     
      #日数据
      day = DayPanel.new(ctrl)
      ctrl.add_page( day, "日线数据", false, page_bmp )
      #实时数据
      real = RealTimePane.new(ctrl)
      ctrl.add_page( real, "实时数据", false, page_bmp )
      
      ctrl.add_page( create_html_ctrl(ctrl), 
        "公司介绍", false, page_bmp)
      
      ctrl.add_page( create_html_ctrl(ctrl), 
        "关于", false, page_bmp)
      
      ctrl
    end
  end
 
  
  module Events
    
    #update frame
    def do_update
      @mgr.update
    end

    #背景消除
    def on_erase_background(event)
      event.skip
    end
    
    #改变大小
    def on_size(event)
      event.skip
    end
    
    #关闭面板
    def on_pane_close(event)
      if event.get_pane.get_name == "test10"
        msg = "Are you sure you want to close/hide this pane?"
        dlg = Wx::MessageDialog.new(self, msg, "Wx::AUI", Wx::YES_NO)
        if dlg.show_modal != Wx::ID_YES
          return event.veto
        end
      end
    end
    
    #
    def on_exit
      close(true)
    end
    
    #关于
    def on_about
      msg = "Wx::AUI Demo\nAn advanced window management library for wxRuby\nAdapted by Alex Fenton from the wxWidgets AUI Demo\n which is (c) Copyright 2005-2006, Kirix Corporation"
      dlg = Wx::MessageDialog.new(self, msg, "Wx::AUI", Wx::OK)
      dlg.show_modal
    end
    
    def get_start_position
      origin = client_to_screen( Wx::Point.new(0, 0) )
      return Wx::Point.new(origin.x + 20, origin.y + 20)
    end
    
    ##
    #股票信息
    def stock_refresh(code)
      
      busy_info do
        $PREFS[:code]="#{code}.ss"
        data = CHRED.get_list($PREFS[:code],$PREFS[:startDate],$PREFS[:endDate])
        unless data.size<=0
          $PREFS[:dat]= data
        else
          throw "读取日线数据失败!"
        end
        stand = CHRED.get_stand($PREFS[:code]) 
        unless stand.nil?
          $PREFS[:stand] =stand
        else
          throw "读取标准股票数据失败!"
        end
       
        @stock_index.draw_index()
        @stock_index.refresh
        self.refresh
      end
      
    end
    ##
    #忙碌
    def busy_info()
      Wx::WindowDisabler.disable(self) do
        Wx::BusyInfo.busy("读取股票数据, 请您耐心等待...", self) do
          begin
            yield
          rescue Exception => ex
            error_dialog = Wx::MessageDialog.new(self, "错误:#{ex}",ex)
            error_dialog.show_modal()
          end
        end
      end
    end
  
  end
  
end

