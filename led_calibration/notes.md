Notes on LED Calibration Handbook
=================================

[LED Calibration Handbook](https://github.com/edwardtoday/LED-Calibration/tree/master/ref/LED%20Calibration%20Handbook)

-   要校正亮度，一般在L\*u\*v\*（或LAB、Luv等）色彩空间对L\*通道进行处理。这类色彩空间根据人的视觉原理建模。比起RGB色彩空间，能直接反映我们实际感知到的亮度、色彩。

-   要校正色彩，我们需要测量实际输出的色彩（一般是17\*17\*17个点），生成一个3D LUT，所有传给屏幕映射的信号先通过3D LUT映射到校正后的色彩空间。

-   同样强度的红/绿/蓝光，人眼感知到绿光最\*亮\*。可见光谱中，人的视觉系统相对亮度灵敏度呈钟形，550nm附近高，400和700端低。反映到色彩上，就是绿色高，黄色次之，红和紫低。

-   不同的相机可能使用不同的color filter array，配合不同的demosaicing算法得到的图像质量也不同。常见的是Bayer filter。

-   Color space = color model + mapping function to a reference

-   显示屏标准色温6500K

-   CIELAB改chroma，感知到的lightness of color不变；HSL改saturation则lightness of color也改变

-   转换到CIELAB空间需要指定白点

-   亮度感知和发光强度的关系是非线性的，需要作 [gamma correction](https://en.wikipedia.org/wiki/Gamma_correction#Power_law_for_video_display)。

-   HSL和HSV的hue是同一属性，但是saturation区别极大。

-   [这里](https://en.wikipedia.org/wiki/HSL_and_HSV#Disadvantages)有彩色照片, CIELAB L\*, Rec. 601 luma Y′, Component average: "intensity" I, HSV value V 和 HSL lightness L通道的对比图。其中，考虑视觉原理的L\*和Y′明显更能反映人眼看到的“亮度”。

-   从拍摄照片的角度入手解决非正对屏的形变问题，可以用 [移轴镜头](http://www.canon.com.cn/specialsite/canon_tselens/7.html)。

-   软件方面，ImageMagick一定程度上可以纠正形变，官网有个 [例子](http://www.imagemagick.org/Usage/distorts/#perspective)。


