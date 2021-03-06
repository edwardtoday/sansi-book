显示屏亮度校正 Memo
===================

校正流程：

PC图像映射至LED全彩屏⇒图像采集⇒解读Raw图片⇒取亮度⇒计算校正参数⇒发送至屏测试

性能问题：

-   多线程

-   OpenCL

> **Note**
>
> 不过OpenCV的GPU加速目前(version 2.4.8)只支持CUDA。先实现校正，再考虑用什么途径加速。

考虑到图像处理库的易用性，语言在python和c++中选。初期可以用python+opencv写，后期如果遇到性能问题，找瓶颈，如果是python代码，改用c实现。不过现在python的图像处理库大多用c写后端函数，提供python接口，所以性能一般不会差太多（除非和IPP这种利用SSE和AVX指令集的Intel专用库比较）。

图像映射
--------

PC上显示的信号，屏幕上一一映射RGB值

图像采集
--------

-   厂区：暗室拍照

-   室外：安装位置拍照

可调参数

1.  物距、焦距

2.  光圈、快门

3.  RAW、JPEG

4.  大屏分块拍摄的块尺寸

需要解决的问题

1.  降噪（变动的环境影响） → 拍N张照片，对齐，取平均，让噪声叠加后被缩小至N分之一

2.  降噪（固定的环境影响） → 关屏幕拍摄，找到零点

3.  同一设置下，连续两张照片，算出的亮度值不一致

4.  自动采集

    -   [libgphoto2](http://gphoto.sourceforge.net/proj/libgphoto2/support.php) 支持多种相机，其中不少除了Image Capture，还可以Liveview, Configuration。

解读RAW图片
-----------

目前看来以下两种途径可行

-   调用ImageMagick或dcraw进程处理raw文件，读取处理结果

-   链接libraw库，直接读取raw图像

考虑实现复杂程度的话，调用外部程序读raw的方式，开发时会更方便做实验比较。把处理好的raw写成16bit的tiff，也让后续处理时库的选择几乎不会再遇到格式支持问题。

思考：对图像作哪些处理可以改善效果？

镜头引起的畸变和暗角可以在这一步解决。

亮度信息获取
------------

可调参数

1.  像素半径

2.  目标亮度

需要解决的问题

1.  识别屏幕边缘

    -   非屏幕中心法向拍摄的照片，要校正畸变

    -   非屏幕中心法向拍摄的照片，要校正感知亮度因拍摄角度而产生的细微变化

2.  像素的识别

3.  坏点的识别

4.  遮挡的识别（集中在一起的许多坏点？）

5.  选取合适的色彩空间

    -   [python-colormath](https://code.google.com/p/python-colormath/)

    -   [scikit-image](http://scikit-image.org/)

    -   [opencv:cvtColor](http://docs.opencv.org/modules/imgproc/doc/miscellaneous_transformations.html?highlight=cvtcolor#cv2.cvtColor)

6.  像素亮度如何定义

计算校正参数
------------

需要解决的问题

1.  RGB单色均匀性

2.  统一白点

3.  要提供校正曲线，因为各通道输出一般都是非线性的

4.  模块边缘偏暗

    -   小点距屏模块间点距精度不够

    -   单屏拍摄时，边缘像素比中心像素的周围发光体数量少，感知到的总光通量小

发送至屏测试
------------

目前把校正参数上传给控制器，慢。

需要解决的问题

1.  在PC端应用矫正，映射矫正结果到屏，实时预览

2.  PC端矫正参数能否转换成屏端矫正参数？效果是否可能一致？


