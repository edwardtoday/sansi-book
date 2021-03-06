Notes on Poynton’s FAQs
=======================

[ColorFAQ](https://github.com/Sansi/LED-Calibration/blob/master/ref/ColorFAQ.pdf) & [GammaFAQ](https://github.com/Sansi/LED-Calibration/blob/master/ref/GammaFAQ.pdf)

-   把全黑和全白的强度记为1和100。如果两个灰阶（线性表示）的差值大于0.01，人眼可以分辨。所以大约需要14bit的深度来表示灰阶。

-   如果上一条的灰阶用非线性表示方法（考虑视觉系统的非线性），则需要约9bit深度。

-   感知到的亮度(Lightness)非线性，CIE作如下定义

![Lightness](https://raw.github.com/edwardtoday/sansi-book/master/assets/ledcalib/eqn7765.png)

-   根据上式，感知到亮度减半的实际luminance其实只有参考值的18%

-   当前适合描述色彩的有： CIE XYZ, CIE xyY, CIE L\*u\*v\*, CIE L\*a\*b\*

-   XYZ系统描述色彩与感知的不一致性在80:1，CIE L\*u\*v\* 和 CIE L\*a\*b\* 降到大约6:1。代价是大量计算。后两者不适合有实时回放需求的视频，但用在静态的照片上，还是不错的。

-   HSL、HSV中的hue和saturation对描述色彩帮助不大，因为它们没有考虑视觉原理

-   同样radiance下的亮度，G\>R\>B。所以用(R+G+B)/3估计亮度是不靠谱的。Rec. 709标准中计算亮度的权重如下

![Brightness](https://raw.github.com/edwardtoday/sansi-book/master/assets/ledcalib/eqn6522.png)

-   8bit精度的gamma矫正误差大，肉眼可见。一般在采集时由采集设备直接做，10或12bit精度。


