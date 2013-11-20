{%include file="doctype.tpl"%}
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="static/webappservice/images/dingquan_images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="../css/base.css">
<link rel="stylesheet" type="text/css" href="../css/newfooter.css">
<link rel="stylesheet" type="text/css" href="../css/webPrompt.css">
<!-- <link rel="stylesheet" type="text/css" href="../css/addsite.css"> -->
<link rel="stylesheet" type="text/css" href="../css/normalbase.css">
<link rel="stylesheet" type="text/css" href="../css/step_bar.css">
<link rel="stylesheet" type="text/css" href="../css/new_myWebapp.css">
<title>我的webapp管理</title>
</head>
<body>
    {%if $sys == "msa"%}{%include file="ecomheader.tpl"%}{%else%}{%include file="header.tpl"%}{%/if%}
<div class="wrap"> 
    {%if $sys != "msa"%}
      {%include file="nor_header.tpl"%}
    {%/if%}

    <div class="outline">
        <div id="add_newsite">
            <div id='addBtn'>
                <span>添加新站点</span>
            </div>
        </div>

        <div class="app_collection">
            {%foreach from=$ret.list item=appinfo key=id%}
            <!-- 1 -->
            <div class='app_item'  data="{%$appinfo.id|escape:html%}">
                <div class='app_info'  data="{%$appinfo.id|escape:html%}">
                    
                    {%if $appinfo.ico_url%}
                        <img class='ico_img' src="{%$appinfo.ico_url|escape:html%}" />
                    {%else%}
                        <img class='ico_img' src="../images/new_myWebapp/white_bg.png" /> 
                    {%/if%}
                    
                    
                    <div class='app_baseinfo'>
                        <div class='app_title_div'>
                            <div class='m_after' style='display:none'>
                                <input class='app_title_input' type='text' >
                                <a class='title_ok'>确定</a>
                                <a class='title_cancel' href="#">取消</a>
                                <span class='tip'></span>
                            </div>
                            <div class='m_before' style='display:inline-block'>
                                <span class='app_title'>
                                    {%if $appinfo.site_title%}
                                         {%$appinfo.site_title|escape:html%}
                                    {%else%}
                                         WebApp_{%$id+1%}
                                    {%/if%}
                                </span>        
                                <a class='modify_title' href="#">编辑</a>
                            </div>
                            
                            
                            {%if $appinfo.is_verified eq 1%}
                            <span class='state_word'>
                                
                                {%if $appinfo.state eq 4%}
                                    域名未解析
                                {%/if%}
                                {%if $appinfo.state eq 5%}
                                    审核中
                                {%/if%}
                                {%if $appinfo.state eq 7%}
                                    审核未通过
                                    <span class="nopassTip span_tip">    
                                        <div class="webBubble">
                                            <div class="bubble-t">
                                                <span id="bubbleClose"></span>
                                            </div>
                                            <div class="bubble-c" id="bubbleCont">
                                                {%$appinfo.stateinfo|escape:html%}
                                            </div>
                                        </div>
                                    </span>
                                {%/if%}
                                {%if $appinfo.state eq 9%}
                                    已封禁
                                    <span class="fobidTip span_tip" >
                                        <div class="webBubble">
                                            <div class="bubble-t">
                                                <span id="bubbleClose"></span>
                                            </div>
                                            <div class="bubble-c" id="bubbleCont">
                                                {%$appinfo.stateinfo|escape:html%}
                                            </div>
                                        </div>
                                    </span>
                                {%/if%}
                            </span>
                            {%/if%}

                        </div>
                        <div class='app_site_div'>
                            <span class='site_tip'>PC域名</span>
                            <span class='pc_site'>{%$appinfo.pc|escape:html%}</span>

                            <span class='bind_png {%if $appinfo.mobile%}bind_blue{%else%}bind_grey{%/if%}'></span>
                            <span class='site_tip'>移动域名</span>
                            <span class='wap_site'>    
                                <em style='font-size:12px;font-style:normal;'>部署</em>&nbsp;&nbsp;
                                {%if $appinfo.mobile %}
                                    {%if $appinfo.state == 6 %}
                                        <a href="{%$appinfo.mobile|escape:html%}" class='wap_site_a wap_use' target='_blank'>{%$appinfo.mobile|escape:html%}</a>
                                    {%else%}
                                        <a href="javascript:void(0);" class='wap_notuse'>{%$appinfo.mobile|escape:html%}</a>
                                    {%/if%}
                                {%else%}
                                    <em style='font-size:12px;font-style:normal;'>未配置</em>
                                {%/if%}
                            </span>
                            {%if $appinfo.state < 5%}
                            <span style='color:#c00;margin-left: 6px;display: inline-block;height: 30px;line-height: 30px;'>未生效</span>
                            {%/if%}
                            <span class='default_wap_site'>
                                <em style='font-size:12px;font-style:normal;'>默认</em>&nbsp;&nbsp;
                                {%if $sys == 'msa'%}
                                    {%if $appinfo.state == 6 %}
                                        <a href="siteapp.baidu.com/site/{%$appinfo.pc|escape:html%}" target='_blank' class='d_wap_site_a wap_use'>siteapp.baidu.com/site/{%$appinfo.pc|escape:html%}</a>
                                    {%else%}
                                        <a href="javascript:void(0);"  class='d_wap_site_a wap_use' style='pointer:default;'>siteapp.baidu.com/site/{%$appinfo.pc|escape:html%}</a>
                                    {%/if%}
                                    
                                {%else%}        
                                    {%if $appinfo.state == 6 %}
                                        <a href="siteapp.baidu.com/webapp/{%$appinfo.pc|escape:html%}" target='_blank' class='d_wap_site_a wap_use'>siteapp.baidu.com/webapp/{%$appinfo.pc|escape:html%}</a>
                                    {%else%}
                                        <a href="javascript:void(0);" target='_blank' class='d_wap_site_a wap_use' style='pointer:default;'>siteapp.baidu.com/webapp/{%$appinfo.pc|escape:html%}</a>
                                    {%/if%}    
                                    
                                {%/if%}
                            </span>
                                
                            </span>
                            
                        </div>
                    </div>
                    <div class='app_btn'>
                        
                        {%if $appinfo.state eq 111 || $appinfo.state eq 112  || $appinfo.state eq 113 || $appinfo.state <= 3 %}
                            <a href="{%$stepstates[$appinfo.state].c_href|escape:html%}?appid={%$appinfo.id|escape:html%}&siteurl={%$appinfo.pc|escape:html%}"  class="btn_continue">继续建站</a>
                        {%else%}
                            {%if $appinfo.state eq 7%}
                                <a href="javascript:void(0);"  class="btn_continue re_submit">重新提交</a>
                            {%elseif $appinfo.state eq 9%}
                                <a href="mailto:siteapp@baidu.com"  class="btn_continue">联系我们</a>
                            {%elseif $appinfo.state != 5 %}
                            <a href="webapp_preview/?appid={%$appinfo.id|escape:html%}&siteurl={%$appinfo.pc|escape:html%}&pageNo=1#page=1" target='_blank' class="btn_view">查看效果</a>
                            {%/if%}
                        {%/if%}
                    </div>


                    {%if $appinfo.state eq 6%}
                        <img class='qr_img' src="../images/new_myWebapp/qrcode_0.png" />
                        <span class='real_qrcode' style='display:none' data='{%$appinfo.mobile|escape:html%}'></span>
                        <div class='layer layer_qrcode' style='display:none'></div>
                    {%/if%}
                    {%if $sys == 'msa'%}
                        {%if $appinfo.nest eq 1%}
                    <label class='tg_label'><input type='checkbox' class='tg_check' data='{%$appinfo.pc|escape:html%}' checked/>启用推广</label>
                    {%else%}
                    <label class='tg_label'><input type='checkbox' class='tg_check' data='{%$appinfo.pc|escape:html%}'/>启用推广</label>
                    {%/if%}
                    {%/if%}
                    <span class='app_state_dot {%if $appinfo.state eq 6%}green_dot{%else%}red_dot{%/if%}'></span>

                    <a class='del_app' href="#" data='{% $appinfo.id|escape:html%}'>删除</a>
                </div>
                <div class='app_moreinfo' style='display:none'>
                    <div class='app_stepbar'>
                        <span class='step_span'>创建步骤</span>
                            {%include file="step_bar_m.tpl"%}
                    </div>
                    <div class='app_funcs'>
                        <span class='funcs_span'>扩展功能</span>
                        <ul class='funcs_ul'>
                            {%if $appinfo.is_verified==1&&$appinfo.is_in_light_app==1%}
                            <li><a href="{%$lightapp_manage_url|escape:html%}" target="_blank"
                            class="use ad_manager_entry">服务推送</a></li>
                            <span class='li_gap'></span>
                            {%/if%}

                            {%if  $sys != 'msa' %}
                                {%if $appinfo.mobile != ''  && $appinfo.is_dns_validate == 1 %}  
                                <li><a href='/union_ads/?appid={%$appinfo.id|escape:html%}' target="_blank" class="use ad_manager_entry">变现管理</a></li>
                                {%else%}
                                <li><a href='#' target="_blank" class="ad_manager_entry ad_notok" style='position:relative'>变现管理
                                    <div class="webBubble ad_tip" style="display:none">
                                        <div class="bubble-t">
                                            <span id="bubbleClose"></span>
                                        </div>
                                        <div class="bubble-c" id="bubbleCont">
                                            请先进行域名部署
                                        </div>
                                    </div>
                                </a></li>
                                {%/if%}
                                <span class='li_gap'></span>
                            {%/if%}

                            
                            <li><a href='webapp_preview/?appid={%$appinfo.id|escape:html%}&siteurl={%$appinfo.pc|escape:html%}&pageNo=1#page=1' target="_blank" class="use">优化工具</a></li>
                            
                            <span class='li_gap'></span>

                            <!-- {%if $appinfo.report_status %}
                            <li><a href="/report?appid={%$appinfo.id|escape:html%}" class="use" target="_blank">质量报告</a></li>
                            {%else%}
                            <li><a href='#'>质量报告</a></li>
                            {%/if%}
                            <span class='li_gap'></span> -->

                            {%if $appinfo.state==6%}

                            {%if $sys != 'msa'%}
                            {%if $appinfo.mtc_type==0%}
                            <li><a href="javascript:void(0)" class="use  unmtcCheck toTest" data="{%$appinfo.id|escape:html%}">提交测试
                                    <div class="webBubble toTest_tip" style="display:none">
                                        <div class="bubble-t">
                                            <span id="bubbleClose"></span>
                                        </div>
                                        <div class="bubble-c" id="bubbleCont">
                                            测试的结果显示您的webapp在不同分辨率、系统、浏览器下的展现样式。预计10分钟后展示测试结果，欢迎查看！
                                        </div>
                                    </div>
                                    <div class="webBubble testing_tip" style="display:none">
                                        <div class="bubble-t">
                                            <span id="bubbleClose"></span>
                                        </div>
                                        <div class="bubble-c" id="bubbleCont">
                                            已提交测试，预计分析时间在10分钟左右，欢迎随后查看效果！
                                        </div>
                                    </div>
                            </a></li>
                            {%elseif  $appinfo.mtc_type==1%}
                            <li><a href="#" class="use testing">测试中
                                    <div class="webBubble testing_tip" style="display:none">
                                        <div class="bubble-t">
                                            <span id="bubbleClose"></span>
                                        </div>
                                        <div class="bubble-c" id="bubbleCont">
                                            已提交测试，预计分析时间在10分钟左右，欢迎随后查看效果！
                                        </div>
                                    </div>
                            </a></li>
                            {%elseif  $appinfo.mtc_type==2%}
                            <li><a href="http://mtc.baidu.com/?pname=webapprun&jobid={%$appinfo.job_id%}" target="_blank" class="use">查看测试结果</a></li>
                            {%/if%}
                            <span class='li_gap'></span>
                            {%/if%}

                            <li><a  href="/app_builder?appid={%$appinfo.id|escape:html%}" class="use">生成应用</a></li>
                            <span class='li_gap'></span>
                            {%if $sys != 'msa'%}
                            <li><a href="/webapp_stat/?appid={%$appinfo.id|escape:html%}" class="use" target="_blank">统计服务</a></li>
                            {%else%}
                            <li><a href="http://tongji.baidu.com/web/{%$appinfo.userid|escape:html%}/overview/index?siteId={%$appinfo.siteid|escape:html%}" class="use" target="_blank">统计服务</a></li>
                            {%/if%}
                            <!-- <span class='li_gap'></span>
                            <li><a href='#' class='pc_adapt adapt_click use' data="{%$appinfo.pc|escape:html%}">域名适配
                                    <div class="webBubble pc_adapt_tip" style="display:none">
                                        <div class="bubble-t">
                                            <span id="bubbleClose"></span>
                                        </div>
                                        <div class="bubble-c" id="bubbleCont">
                                            代码嵌入PC网页头部，令手机终端在访问PC网站时转至对应的WebApp域名
                                        </div>
                                    </div>
                            </a></li> -->
                            
                            {%else%}
                            {%if $sys !='msa'%}
                            <li><a href='#' class='toTest'>提交测试
                                    <div class="webBubble toTest_tip" style="display:none">
                                        <div class="bubble-t">
                                            <span id="bubbleClose"></span>
                                        </div>
                                        <div class="bubble-c" id="bubbleCont">
                                            测试的结果显示您的webapp在不同分辨率、系统、浏览器下的展现样式。预计10分钟后展示测试结果，欢迎查看！
                                        </div>
                                    </div>
                            </a></li>
                            <span class='li_gap'></span>
                            {%/if%}
                            <li><a href='#'>生成应用</a></li>
                            <span class='li_gap'></span>
                            <li><a href='#'>统计服务</a></li>
                            <!-- <span class='li_gap'></span>
                            <li><a href='#' class='pc_adapt'>域名适配
                                    <div class="webBubble pc_adapt_tip" style="display:none">
                                        <div class="bubble-t">
                                            <span id="bubbleClose"></span>
                                        </div>
                                        <div class="bubble-c" id="bubbleCont">
                                            代码嵌入PC网页头部，令手机终端在访问PC网站时转至对应的WebApp域名
                                        </div>
                                    </div>
                            </a></li> -->
                            {%/if%}

                            <span class='li_gap'></span>
                            {%if $appinfo.is_verified == 1 %}
                            <li><a href='/bind_domain/?appid={%$appinfo.id|escape:html%}&siteurl={%$appinfo.pc|escape:html%}' class='use'>域名部署</a></li>
                            {%else%}
                            <li><a href='javascript:void(0);'>域名部署</a></li>
                            {%/if%}
                            {%if $sys == 'msa'%}

                                <span class='li_gap'></span>
                                {%if  $appinfo.is_pro_user%}
                                <li><a href='/senior_editor?appid={%$appinfo.id|escape:html%}' target='_blank' class='use'>高级定制</a></li>
                                {%else%}
                                <li><a href='javascript:void(0);'>高级定制</a></li>
                                {%/if%}
                            {%/if%}

                            
                        </ul>
                    </div>
                </div>
                <div class='arrow_div'></div>
            </div>

            {%/foreach%}

            

        </div>    
    </div>    
    {%if $sys != 'msa'%}{%include file="nor_footerInfo.tpl"%}{%/if%}
</div>

<!-- 上传自定义ico -->
<div id='layer_ico' class='layer' style='display:none' >
    <div id='ico_dialog' data=''>
        <span id='ico_title'>手机 Baidu</span>

        <!-- <img id='ico_img' src='../images/new_myWebapp/white_bg.png'/> -->

        <div id='ico_before' class='ico_right'>
            <span class='ico_tip'>请选择jpg,png格式，尺寸为117px*117px的图片，该图片作为将网页保存至手机桌面的icon(ios系统)</span>
            <span id='ico_eroor'><!-- 文件格式不正确 --></span>
            <div class='ico_btns'>
                <span id='ico_upload'>上传图片</span>
                <!-- <span id='ico_save' style='display:none'>保存</span> -->
                <span id='ico_cancel'>取消</span>
                <form id='ico_form' method="POST"   action=""  target="frame1"   enctype="multipart/form-data" style='display:none'>
                    <input type="file" id="file_input" name="logfile" accept="image/gif, image/jpeg,image/png"/>
                </form>
            </div>
        </div>

        <!-- <div id='ico_after' class='ico_right' style='display:none'>
            <span class='ico_up_tip'>图片加载中，请稍候...</span>
            <div class='ico_progress'>
                <span class="progress_bg">
                    <span id="progress_bar"></span>
                </span>    
                <a id='progress_cancel' href="">取消</a>
            </div>
            <div class='ico_btns'>
                <span id='ico_upload'>保存</span>
            </div>
        </div> -->
    </div>
</div>



<!-- 域名适配代码 -->
<div id='layer_adapt' class='layer' style='display:none' >
    <div id="copyMask" ></div>
    <div id="pc_domain">
        <div class="pc_close">
            <span id="pc_close_ico"></span>
        </div>
        <div class="pc_tip">将以下代码嵌入<span id="pc_site"></span>的网页头部，可令手机端在访问PC网站时转至对应的WebApp域名</div>
        <div class="pc_code">
            <textarea id="code_text"></textarea>
            <span id="copy_btn"></span>
        </div>
    </div>
</div>


<iframe name="frame1" style="opacity:0; height:1px;"></iframe>
<img src="" id="hidden_img" style='display:none'/>
<script type="text/javascript">
    var sys = '{%$sys|escape:javascript%}';
    var data = '{%$ret|escape:none%}';


</script>


{%include file="footer.tpl"%}

<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.json-2.3.min.js"></script>
<script type="text/javascript" src="../js/jquery.form.js"></script>
<script type="text/javascript" src="../js/jquery.qrcode.js"></script>
<script type="text/javascript" src="../js/qrcode.js"></script>
<script type="text/javascript" src="../js/util.js"></script>
<script type="text/javascript" src="../js/cpClipboard.js"></script>
<script type="text/javascript" src="../js/webPrompt.js"></script>
<script type="text/javascript" src="../js/new_myWebapp.js"></script>






</body>

</html>
