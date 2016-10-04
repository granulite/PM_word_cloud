# 4.wordcloud2函数说明
# wordcloud2(data, size = 1, minSize = 0, gridSize =  0,
#            fontFamily = NULL, fontWeight = 'normal',
#            color = 'random-dark', backgroundColor = "white",
#            minRotation = -pi/4, maxRotation = pi/4, rotateRatio = 0.4,
#            shape = 'circle', ellipticity = 0.65, widgetsize = NULL)
# 
# 常用参数：
# （1）data：词云生成数据，包含具体词语以及频率；
# （2）size：字体大小，默认为1，一般来说该值越小，生成的形状轮廓越明显；
# （3）fontFamily：字体，如‘微软雅黑’；
# （4）fontWeight：字体粗细，包含‘normal’，‘bold’以及‘600’；；
# （5）color：字体颜色，可以选择‘random-dark’以及‘random-light’，其实就是颜色色系；
# （6）backgroundColor：背景颜色，支持R语言中的常用颜色，如‘gray’，‘blcak’，但是还支持不了更加具体的颜色选择，如‘gray20’；
# （7）minRontatin与maxRontatin：字体旋转角度范围的最小值以及最大值，选定后，字体会在该范围内随机旋转；
# （8）rotationRation：字体旋转比例，如设定为1，则全部词语都会发生旋转；
# （9）shape：词云形状选择，默认是‘circle’，即圆形。还可以选择‘cardioid’（苹果形或心形），‘star’（星形），‘diamond’（钻石），‘triangle-forward’（三角形），‘triangle’（三角形），‘pentagon’（五边形）；

# 设置工作文件夹
setwd("~/Dropbox/R/pm_wordcloud")

# 创建函数，读取数据，并生成词频，词频根据频率来
word_freq <- function(file = "pm_leve1.txt", freq = 20, x = 30){
  file_read <- read.table(file, header = FALSE, quote = "\"")
  random_value <- (rnorm(nrow(file_read), mean = freq, sd = freq/x))
  file_read <- cbind(file_read, random_value)
  colnames(file_read) <- c("word", "freq")
  return (file_read)
}

## 读取数据
# 产品助理标题
pm <- word_freq("pm.txt", 200)
word <- c("产品", "助理")
freq_pm  <- 200
freq  <- c(freq_pm, freq_pm)
pm <- data.frame(word, freq)
###############################################
################产品经理关键词#################
###############################################
# 产品经理能力模型1-9
## 产品助理主要是初阶技能 1--4
pm_level1 <- word_freq("pm_leve1.txt", 80)
pm_level2 <- word_freq("pm_leve2.txt", 75)
pm_level3 <- word_freq("pm_leve3.txt", 75)
pm_level4 <- word_freq("pm_leve4.txt", 65)
pm_level5 <- word_freq("pm_leve5.txt", 50)
pm_level6 <- word_freq("pm_leve6.txt", 40)
pm_level7 <- word_freq("pm_leve7.txt", 30)
pm_level8 <- word_freq("pm_leve8.txt", 20)
pm_level9 <- word_freq("pm_leve9.txt", 5)
# 做产品经理最好具备大一些特质
pm_property <- word_freq("pm_property.txt", 25)
# PM应该学习的软件
pm_software <- word_freq("pm_software.txt", 20)
# PM日常关键词
pm_daily_keywords <- word_freq("pm_daily_keywords.txt", 35)
#########工作业务相关############################
# 在校宝在线做的项目列表
xiaobao_work <- word_freq("xiaobao_work.txt", 80)
# 校宝企业关键词
xiaobao_keywords <- word_freq("xiaobao_keywords.txt", 25)
# 1Course产品关键词
xiaobao_1Course <- word_freq("xiaobao_1Course.txt", 25)
# 互联网关键词
internet_keywords <- word_freq("internet_keywords.txt", 10, 2)

# 产品经理推荐书籍
# 产品经理经典人物
# 产品运营关键词
# 商业模式关键词
# 互联网12大领域 
pm_field <- word_freq("pm_field.txt", 5)
# 前沿技术关键词
# 热门创业领域？


##############################
############开发##############
# 前端开发关键词
web_dev <- word_freq("web_dev.txt", 25)
# 服务器开发关键词
server_dev <- word_freq("server_dev.txt", 15)
# 数据存储
data <- word_freq("data.txt", 20)
# 开发工具
dev_tools <- word_freq("dev_tools.txt", 20)
#############################

############################
##########UED###############
# UED 日常关键词

############################
##########运营###############
# 运营 日常关键词
po_keywords <- word_freq("po_keywords.txt", 25)

# 整合数据
data <- rbind(pm,
              pm_level9, pm_level8, pm_level7, pm_level6, pm_level5,
              pm_level4, pm_level3, pm_level2, pm_level1,
              internet_keywords,
              pm_field,
              pm_property,
              pm_software,
              #开发
              web_dev,
              server_dev,
              dev_tools,
              data,
              #运营
              po_keywords,
              #工作相关
              pm_daily_keywords,
              xiaobao_1Course,
              xiaobao_work,
              xiaobao_keywords
              )

# 根据频率排序
data <- data[rev(order(data$freq)), ]
# 绘图
library(wordcloud2)
#figPath = system.file("xiaobaozaixian.png",package = "wordcloud2")


wordcloud2(data = data, 
           #letter = "R",
           #figPath = figPath,
           size = 1,
           fontFamily = "微软雅黑", fontWeight = 'normal',
           minRotation = 0, maxRotation = 0, rotateRatio = 1,
           shape = 'diamond',
           #ellipticity = 0.666,
           color = "lightgrey"
           #color = "random-dark"
           )
pdf("~/Desktop/file.pdf",width=6,height=4) 
wordcloud2(demoFreq)
wordcloud2(demoFreq, size = 2)
dev.off()
