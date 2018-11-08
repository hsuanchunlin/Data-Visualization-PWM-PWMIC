# plot ggplot
library(ggplot2)


rm(list=ls())
#import PWM+IC model files
Ec <- read.csv("HTSEQ_PWMIC.csv")
Eq <- read.csv("HTSKIN_PWMIC.csv")

#Prepare labels of different datasets
Ec$sep <- "EC"
Eq$sep <- "EQ"

#Data nomralization to define the effect of each nucleotide/position
EQf <- Eq$DINUCINT / Eq$DINUCINT[which.max(Eq$DINUCINT)]
ECf <- Ec$DINUCINT / Ec$DINUCINT[which.max(Ec$DINUCINT)]
EQfb <- EQf

#Prepare the data for visualization
final <- cbind(Ec,Eq)

#Use ggplot to visualize the data
(p <- ggplot(final,aes(X2,X1))
 +geom_point(mapping = aes(fill = Eq$DINUCINT, size = Ec$DINUCINT),
             shape = 21,
             color = rgb(1,1,1,1)
             )
 +scale_fill_gradient2(low="steelblue",mid="white",
                       high="red", midpoint=0,space = "rgb", na.value = "grey50", guide = "colourbar",
                       name="HiTS-EQ")
 +scale_size_continuous(range=c(1,18), name="HiTS-Kin")
 +guides(colour = guide_legend(override.aes = list(colour = "black")))
 +theme_bw()
 +theme(legend.background = element_rect(color="white"),
        legend.key=element_rect(fill="black", colour="transparent"))
 +theme(legend.text = element_text(color="black"))
 +theme(text = element_text(size =20),
        axis.text= element_text(size=20,colour="black")
       )
 +theme(panel.background = element_rect(fill = "black"))
 +labs(size= 20,
       x = "",
       y = ""))
