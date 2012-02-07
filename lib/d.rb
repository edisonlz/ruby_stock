require "open-uri"
g=open("http://finance.google.com.cn/finance?client=ob&q=SHA:600000")
s=g.read
reg=Regexp.new('<div class="item companySummary">[^<>]*?</div>',Regexp::MULTILINE)
m=reg.match(s)
puts m.to_s
