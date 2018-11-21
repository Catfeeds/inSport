package com.fh.util;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.ComThread;
import com.jacob.com.Variant;
import com.jacob.com.Dispatch;
import org.junit.Test;

import java.io.File;
import java.util.Date;

public class ToPdf {

    public static void main(String[] args) throws Exception {
        ActiveXComponent app = null;
        String wordFile = "C:/Users/Administrator/Desktop/岭南/手册/中奥合同信息管理系统使用事项.docx";
        String pdfFile = "C:/Users/Administrator/Desktop/岭南/手册/11.pdf";
        System.out.println("开始转换...");
        // 开始时间
        long start = System.currentTimeMillis();
        try {
            // 打开word
            app = new ActiveXComponent("Word.Application");
            // 设置word不可见,很多博客下面这里都写了这一句话，其实是没有必要的，因为默认就是不可见的，如果设置可见就是会打开一个word文档，对于转化为pdf明显是没有必要的
            //app.setProperty("Visible", false);
            // 获得word中所有打开的文档
            Dispatch documents = app.getProperty("Documents").toDispatch();
            System.out.println("打开文件: " + wordFile);
            // 打开文档
            Dispatch document = Dispatch.call(documents, "Open", wordFile, false, true).toDispatch();
            // 如果文件存在的话，不会覆盖，会直接报错，所以我们需要判断文件是否存在
            File target = new File(pdfFile);
            if (target.exists()) {
                target.delete();
            }
            System.out.println("另存为: " + pdfFile);
            // 另存为，将文档报错为pdf，其中word保存为pdf的格式宏的值是17
            Dispatch.call(document, "SaveAs", pdfFile, 17);
            // 关闭文档
            Dispatch.call(document, "Close", false);
            // 结束时间
            long end = System.currentTimeMillis();
            System.out.println("转换成功，用时：" + (end - start) + "ms");
        }catch(Exception e) {
            System.out.println("转换失败"+e.getMessage());
        }finally {
            // 关闭office
            if (app != null){
                app.invoke("Quit", 0);
            }
            //app.invoke("Quit", 0);
        }
    }


//转换不全
    @Test
    public void excel2pdf() {
        String source = "C:/Users/Administrator/Desktop/岭南/手册/33333.xlsx.AB9489A8C136881C64BB95F89F4E41C3.20180514222325970.et";
        String target = "C:/Users/Administrator/Desktop/岭南/手册/222.pdf";
        System.out.println("启动Excel");
        //System.out.println("F F 9 A 3 F 0 3 - 5 6 E F - 4 6 1 3 - B D D 5 - 5 A 4 1 C 1 D 0 7 2 4 6".trim());
        ActiveXComponent activeXComponent = new ActiveXComponent("Excel.Application");
        activeXComponent.setProperty("Visible", false);

        Dispatch excels = activeXComponent.getProperty("Workbooks").toDispatch();
        Dispatch excel = Dispatch.call(excels, "Open", source, false, true).toDispatch();
        Dispatch.call(excel, "ExportAsFixedFormat", 0, target);
        Dispatch.call(excel, "Close", false);
        activeXComponent.invoke("Quit");
    }

    @Test
    public void Ex2PDF() {
        try {
            String inputFile = "C:/Users/Administrator/Desktop/岭南/手册/test.xlsx";
            String pdfFile = "C:/Users/Administrator/Desktop/岭南/手册/222.pdf";
            ComThread.InitSTA(true);
            ActiveXComponent ax = new ActiveXComponent("Excel.Application");
            System.out.println("开始转化Excel为PDF...");
            long date = new Date().getTime();
            ax.setProperty("Visible", false);
            ax.setProperty("AutomationSecurity", new Variant(3)); // 禁用宏
            Dispatch excels = ax.getProperty("Workbooks").toDispatch();

            Dispatch excel = Dispatch
                    .invoke(excels, "Open", Dispatch.Method,
                            new Object[] { inputFile, new Variant(false), new Variant(false) }, new int[9])
                    .toDispatch();
            File tofile = new File(pdfFile);
            if (tofile.exists()) {
                tofile.delete();
            }
            // 转换格式
            Dispatch.invoke(excel, "ExportAsFixedFormat", Dispatch.Method, new Object[] { new Variant(0), // PDF格式=0
                    pdfFile, new Variant(0) // 0=标准 (生成的PDF图片不会变模糊) 1=最小文件
                    // (生成的PDF图片糊的一塌糊涂)
            }, new int[1]);

            // 这里放弃使用SaveAs
            /*
             * Dispatch.invoke(excel,"SaveAs",Dispatch.Method,new Object[]{
             * outFile, new Variant(57), new Variant(false), new Variant(57),
             * new Variant(57), new Variant(false), new Variant(true), new
             * Variant(57), new Variant(true), new Variant(true), new
             * Variant(true) },new int[1]);
             */
            long date2 = new Date().getTime();
            int time = (int) ((date2 - date) / 1000);
            Dispatch.call(excel, "Close", new Variant(false));

            if (ax != null) {
                ax.invoke("Quit", new Variant[] {});
                ax = null;
            }
            ComThread.Release();
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }
}
