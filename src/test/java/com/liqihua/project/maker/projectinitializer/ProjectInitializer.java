package com.liqihua.project.maker.projectinitializer;


import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.junit.jupiter.api.Test;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

class ProjectInitializer {

    private static Map<String,Object> param = new HashMap<String, Object>();
    private static Configuration config = new Configuration(Configuration.getVersion());

    static {
        try {
            config.setDirectoryForTemplateLoading(new File(new File("").getAbsolutePath() + "/src/main/resources/templates"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    @Test
    public void test1() {
        String sourcePath = new File(new File("").getAbsolutePath() + "/src/main/resources/templates/web/resource/swagger").getAbsolutePath();
        System.out.println(sourcePath);
    }

    @Test
    public void makeProject() {
        String root = "F://code//";
        String projectName = "travel-saas-manager";
        String packageName = "com.wehotel.travel.saas.manager";
        String packagePath = packageName.replace(".",File.separator);
        String codePath = File.separator + "src" + File.separator + "main" + File.separator + "java" + File.separator + packagePath + File.separator;

        String projectDir = root + projectName;
        String beanDir = root + projectName + File.separator + projectName + "-bean";
        String commonDir = root + projectName + File.separator + projectName + "-common";
        String daoDir = root + projectName + File.separator + projectName + "-dao";
        String serviceDir = root + projectName + File.separator + projectName + "-service";
        String webDir = root + projectName + File.separator + projectName + "-web";

        String commonCodePath = commonDir + codePath + "common";
        String beanCodePath = beanDir + codePath + "bean";
        String daoCodePath = daoDir + codePath + "dao";
        String daoMapperPath = daoDir + File.separator + "src" + File.separator + "main" + File.separator + "resources" + File.separator + "mapper";
        String serviceCodePath = serviceDir + codePath + "service";
        String webCodePath = webDir + codePath + "web";
        String webResourcesPath = webDir + File.separator + "src" + File.separator + "main" + File.separator + "resources";


        new File(projectDir).mkdirs();
        new File(commonCodePath).mkdirs();
        new File(beanCodePath).mkdirs();
        new File(daoCodePath).mkdirs();
        new File(daoMapperPath).mkdirs();
        new File(serviceCodePath).mkdirs();
        new File(webCodePath).mkdirs();
        new File(webResourcesPath).mkdirs();




        param.put("projectName", projectName);
        param.put("packageName", packageName);



        makeFile("/pom/root_pom.ftl",projectDir,"pom.xml");
        makeFile("/pom/common_pom.ftl",commonDir,"pom.xml");
        makeFile("/pom/bean_pom.ftl",beanDir,"pom.xml");
        makeFile("/pom/dao_pom.ftl",daoDir,"pom.xml");
        makeFile("/pom/service_pom.ftl",serviceDir,"pom.xml");
        makeFile("/pom/web_pom.ftl",webDir,"pom.xml");


        makeFile("/common/ResultVO.ftl",commonCodePath + File.separator + "basic","ResultVO.java");
        makeFile("/common/BaseController.ftl",commonCodePath + File.separator + "basic","BaseController.java");


        makeFile("/common/Constants.ftl",commonCodePath + File.separator + "constant","Constants.java");
        makeFile("/common/MsgCode.ftl",commonCodePath + File.separator + "constant","MsgCode.java");
        makeFile("/common/RedisConstant.ftl",commonCodePath + File.separator + "constant","RedisConstant.java");

        makeFile("/common/InfoException.ftl",commonCodePath + File.separator + "exception","InfoException.java");
        makeFile("/common/RemoteApiException.ftl",commonCodePath + File.separator + "exception","RemoteApiException.java");

        makeFile("/common/BasicFeignConfig.ftl",commonCodePath + File.separator + "feign","BasicFeignConfig.java");
        makeFile("/common/InfoFeignLogger.ftl",commonCodePath + File.separator + "feign","InfoFeignLogger.java");
        makeFile("/common/InfoFeignLoggerFactory.ftl",commonCodePath + File.separator + "feign","InfoFeignLoggerFactory.java");


        makeFile("/common/MailUtil.ftl",commonCodePath + File.separator + "utils","MailUtil.java");
        makeFile("/common/SpringContextHolder.ftl",commonCodePath + File.separator + "utils","SpringContextHolder.java");



        makeFile("/web/SysControllerAdvice.ftl",webCodePath + File.separator + "config" + File.separator + "advice","SysControllerAdvice.java");

        makeFile("/web/RateLimit.ftl",webCodePath + File.separator + "config" + File.separator + "aop" + File.separator + "annotation","RateLimit.java");
        makeFile("/web/RateLimitAspect.ftl",webCodePath + File.separator + "config" + File.separator + "aop","RateLimitAspect.java");
        makeFile("/web/RequestBodyValidateAspect.ftl",webCodePath + File.separator + "config" + File.separator + "aop","RequestBodyValidateAspect.java");
        makeFile("/web/RequestControllerAspect.ftl",webCodePath + File.separator + "config" + File.separator + "aop","RequestControllerAspect.java");

        makeFile("/web/DBConfig.ftl",webCodePath + File.separator + "config" + File.separator + "db","DBConfig.java");
        makeFile("/web/MyBatisPlusObjectHandler.ftl",webCodePath + File.separator + "config" + File.separator + "db","MyBatisPlusObjectHandler.java");

        makeFile("/web/MailConfig.ftl",webCodePath + File.separator + "config" + File.separator + "mail","MailConfig.java");

        makeFile("/web/WebConfig.ftl",webCodePath + File.separator + "config" + File.separator + "mvc","WebConfig.java");

        makeFile("/web/RedisConfig.ftl",webCodePath + File.separator + "config" + File.separator + "redis","RedisConfig.java");

        makeFile("/web/SwaggerConfig.ftl",webCodePath + File.separator + "config" + File.separator + "swagger","SwaggerConfig.java");

        makeFile("/web/ThreadPoolConfig.ftl",webCodePath + File.separator + "config" + File.separator + "thread","ThreadPoolConfig.java");
        makeFile("/web/AsyncExceptionHandler.ftl",webCodePath + File.separator + "config" + File.separator + "thread","AsyncExceptionHandler.java");

        makeFile("/web/TestController.ftl",webCodePath + File.separator + "controller","TestController.java");
        makeFile("/web/TestDTO.ftl",webCodePath + File.separator + "controller","TestDTO.java");
        makeFile("/web/TestVO.ftl",webCodePath + File.separator + "controller","TestVO.java");

        makeFile("/web/Application.ftl",webCodePath,"Application.java");

        makeFile("/web/resources/apollo-env.properties.ftl", webResourcesPath,"apollo-env.properties");
        makeFile("/web/resources/application.yml.ftl", webResourcesPath,"application.yml");
        makeFile("/web/resources/bootstrap.yml.ftl", webResourcesPath,"bootstrap.yml");
        makeFile("/web/resources/log4j2.xml.ftl", webResourcesPath,"log4j2.xml");
        makeFile("/web/resources/log4j2-prod.xml.ftl", webResourcesPath,"log4j2-prod.xml");

        makeFile("/web/resources/api.html.ftl", webResourcesPath + File.separator + "static" + File.separator + "swagger","api.html");

        makeFile("/.gitignore.ftl", projectDir,".gitignore");

        /**
         * 复制swagger库
         */
        String sourcePath = new File(new File("").getAbsolutePath() + "/src/main/resources/templates/web/resources/swagger").getAbsolutePath();
        String targetPath = new File(new File(webResourcesPath).getAbsolutePath() + "/static/swagger").getAbsolutePath();
        try {
            copyFolder(sourcePath,  targetPath);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private static void makeFile(String templateFile,String dir, String fileName) {
        try {
            Template template = config.getTemplate( templateFile, "UTF-8");
            StringWriter out = new StringWriter();
            template.process(param, out);
            File targetFile = new File(dir, fileName);
            targetFile.getParentFile().mkdirs();
            targetFile.createNewFile();
            OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream(targetFile), "UTF-8");
            osw.write(out.toString());
            osw.close();
            System.out.println("--------- 生成文件 " + fileName + "-----");
        }catch (IOException e) {
            e.printStackTrace();
        } catch (TemplateException e) {
            e.printStackTrace();
        }
    }


    /**
     * 复制文件夹
     *
     * @param resource 源路径
     * @param target   目标路径
     */
    public static void copyFolder(String resource, String target) throws Exception {

        File resourceFile = new File(resource);
        if (!resourceFile.exists()) {
            throw new Exception("源目标路径：[" + resource + "] 不存在...");
        }
        File targetFile = new File(target);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
            //throw new Exception("存放的目标路径：[" + target + "] 不存在...");
        }

        // 获取源文件夹下的文件夹或文件
        File[] resourceFiles = resourceFile.listFiles();

        for (File file : resourceFiles) {

            File file1 = new File(targetFile.getAbsolutePath() + File.separator + resourceFile.getName());
            // 复制文件
            if (file.isFile()) {
                System.out.println("文件" + file.getName());
                // 在 目标文件夹（B） 中 新建 源文件夹（A），然后将文件复制到 A 中
                // 这样 在 B 中 就存在 A
                if (!file1.exists()) {
                    file1.mkdirs();
                }
                File targetFile1 = new File(file1.getAbsolutePath() + File.separator + file.getName());
                copyFile(file, targetFile1);
            }
            // 复制文件夹
            if (file.isDirectory()) {// 复制源文件夹
                String dir1 = file.getAbsolutePath();
                // 目的文件夹
                String dir2 = file1.getAbsolutePath();
                copyFolder(dir1, dir2);
            }
        }
    }


    /**
     * 复制文件
     *
     * @param resource
     * @param target
     */
    public static void copyFile(File resource, File target) throws Exception {
        // 输入流 --> 从一个目标读取数据
        // 输出流 --> 向一个目标写入数据

        long start = System.currentTimeMillis();

        // 文件输入流并进行缓冲
        FileInputStream inputStream = new FileInputStream(resource);
        BufferedInputStream bufferedInputStream = new BufferedInputStream(inputStream);

        // 文件输出流并进行缓冲
        FileOutputStream outputStream = new FileOutputStream(target);
        BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(outputStream);

        // 缓冲数组
        // 大文件 可将 1024 * 2 改大一些，但是 并不是越大就越快
        byte[] bytes = new byte[1024 * 2];
        int len = 0;
        while ((len = inputStream.read(bytes)) != -1) {
            bufferedOutputStream.write(bytes, 0, len);
        }
        // 刷新输出缓冲流
        bufferedOutputStream.flush();
        //关闭流
        bufferedInputStream.close();
        bufferedOutputStream.close();
        inputStream.close();
        outputStream.close();

        long end = System.currentTimeMillis();

        System.out.println("耗时：" + (end - start) / 1000 + " s");

    }

}
