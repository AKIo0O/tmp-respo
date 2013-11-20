/*
    dingquan 
    13.10.18
*/


;$(function(){

    var VARS = {
        icoSrc:''
    };

    var myWebapp = {


        //初始化管理中心
        initialAll:function(){

            //添加新站点
            $("#addBtn").click(function(){
                window.location.href = '/create_site';
            });

            //载入页面只默认展开第一个
            //var app_count = $(".app_item").length;
            $(".app_item").first().find('.app_moreinfo').show();
            $(".arrow_div").first().addClass('hide_arrow');

            //单击展开
            $(".app_info").click(function(e){

                var target = e.target;
                //console.log(target.className);
                if(target.className == 'app_info' || target.className == 'app_title_div' || target.className == 'app_site_div'){
                    $(this).next('.app_moreinfo').show();
                    $(this).closest('.app_item').find('.arrow_div').removeClass('show_arrow');
                    $(this).closest('.app_item').find('.arrow_div').addClass('hide_arrow');

                    $(".hide_arrow").click(function(){
                        $(this).prev().hide();
                        $(this).removeClass('hide_arrow');
                    });
                }
                
            });

            $(".app_info").hover(function(){
                if($(this).next('.app_moreinfo').css('display') == 'none'){
                    $(this).closest('.app_item').find('.arrow_div').addClass('show_arrow');
                }        
            },function(){    
                $(this).closest('.app_item').find('.arrow_div').removeClass('show_arrow');
            });

            //单击收起
            $(".hide_arrow").click(function(){
                $(this).prev().hide();
                $(this).removeClass('hide_arrow');
            });

            //删除一个app
            $(".del_app").click(function(){
                var appid =  $(this).attr("data");
                ymPrompt.confirm('确定删除?', '提示', function(key){
                  if(key == 'ok'){
                      $.ajax({
                          type: "GET",
                          url: "/my_webapp?action=del_site&appid="+appid,
                          dataType:'json',
                          success: function(msg){
                              if(msg.ret == 0){
                                  $(".app_item[data="+appid+"]").remove();
                              }else{
                                  //alert("删除站点失败");
                              }
                          }
                      });
                           
                      }
                  });      
            });

            //状态解释提示
            $(".nopassTip, .fobidTip, .dnsTip").hover(function(){
            
                $(this).find(".webBubble").show();
            },function(){
                $(this).find(".webBubble").hide();

            });

            //未通过审核重新提交
            $(".re_submit").click(function(){
                var appid = $(this).closest('.app_item').attr('data');
                $.ajax({
                    type:"POST",
                    dataType:"json",
                    url:"/my_webapp",
                    data:{
                        "action":"reapply",
                        "appid":appid
                    },
                    success:function(msg){
                        if(msg.ret == 0){
                            //重新提交成功
                            var app_item = $(".app_item[data="+ appid+"]");
                            //app_item.find(".nopassTip").hide();
                            app_item.find(".state_word").text('审核中');
                            app_item.find(".re_submit").hide();

                        }
                    }
                });
            });

            //勾选启用推广
            $('.tg_check').click(function(){
                var nest;
                var nestappid = $(this).closest('.app_item').attr('data');
                var nesturl = $(this).attr('data');
                console.log(nestappid+'ssssss'+nesturl);
                if($(this).attr('checked')){
                    nest = 1;
                }else{
                    nest = 0;
                }

                $.ajax({
                    type: "POST",
                    url: "/edit_option",
                    data: {
                        'action': "set_option",
                        'appid': nestappid,
                        'siteurl': nesturl,
                        settings: JSON.stringify({
                            nest: nest
                        })
                    },
                    success: function(msg){
                        //console.log(msg);
                    }
                });
            });


            this.initialIcos();

            this.showPartURL();

        },
        initialIcos:function(){


            //ico的hover效果
            $(".ico_img").hover(function(){
                VARS.curSrc = $(this).attr("src");
                $(this).attr('src','/static/webappservice/images/ico/customer.png');
            },function(){
                $(this).attr('src',VARS.curSrc);
            });

            
            //ico点击打开上传对话框
            $(".ico_img").click(function(e){

                var appid = $(this).closest(".app_item").attr('data');
                var appTitle = $(this).next().find('.app_title').text();

                $("#layer_ico").show();
            
                $("#ico_dialog").attr('data',appid);
                var appTitle = $(".app_item[data="+appid+"]").find(".app_title").text();
                $("#ico_title").text(appTitle);

                var action = "my_webapp?action=ico_image&appid="+appid;
                $("#ico_form").attr("action",action);

            });

            

            //对话框关闭
            $("#layer_ico").click(function(e){
                if(e.target.id == 'layer_ico'){
                    $("#ico_eroor").text("");
                    $(this).hide();
                }    
            });


        },
        showPartURL:function(){
            $('.pc_site').each(function(index){
                var domEl = $(this);
                var length = domEl.text().length;
                if(length>18){
                    domEl.text(domEl.text().substring(0,18)+'...');
                }
            });

            $('.wap_site_a').each(function(index){
                var domEl = $(this);
                var length = domEl.text().length;
                if(length>30){
                    domEl.text(domEl.text().substring(0,30)+'...');
                }
            });

            
            $('.d_wap_site_a').each(function(index){
                var domEl = $(this);
                var length = domEl.text().length;
                if(length>32){
                    domEl.text(domEl.text().substring(0,32)+'...');
                }
            });
        }    
    };

    //上传ico的对话框
    var upLoadIco = {
        initial:function(){
            var that = this;

            $("#ico_upload").click(function(){
                $("#file_input").trigger("click");
                $("#ico_eroor").text("");
            });

            //$("#file_input").live('change',function(evt){
            $("#file_input").change(function(evt){

                var files = evt.target.files;

                for (var i = 0, f; f = files[i]; i++) {
                    if (!f.type.match('image.*')){
                        continue;
                    }    

                    var reader = new FileReader();
                    reader.onload = (function(theFile) {
                        return function(e) {                                
                            var src = e.target.result;
                            $("#hidden_img").attr('src',src);
                        };
                    })(f);
                    reader.readAsDataURL(f);            
                }

                
                
    
            });

            //取消上传
            $("#ico_cancel").click(function(){
                $("#ico_eroor").text("");
                $("#layer_ico").hide();
            });

            $("#hidden_img").load(function(){
                if($(this)[0].height == 117 && $(this)[0].width == 117){
                    that.ico_submit();
                }else{
                    $("#ico_eroor").text('图片尺寸不符合要求');
                }
            });
        },
        ico_submit:function(){
            var options = {
                    dataType:"json",
                    success:function(msg){
                        if(msg.ret == 0){
                            //console.log(msg.ico_url);
                            var appid = msg.appid;
                            var ico_img = $(".app_item[data="+appid+"]").find(".ico_img");

                            ico_img.attr('src',msg.ico_url);
                            $("#ico_eroor").text("");
                            ico_img.load(function(){
                                    $("#layer_ico").hide();
                                    $(this).unbind('load');
                                    
                                    
                            });
                            
                        }else{
                            $("#ico_eroor").text('上传失败');
                        }
                    }
                };
            $("#ico_form").ajaxSubmit(options);
        }
    };

    //修改app的名称
    var modifyTitle = {
        clickModify:function(){
            $(".modify_title").click(function(){
                var title = $.trim($(this).prev('.app_title').text());

                $(this).closest(".app_title_div").find(".m_after").css('display','inline-block');
                $(this).closest(".m_before").css('display','none');

                $(this).closest(".app_title_div").find(".app_title_input").val(title);


            });
        },
        modifyOk:function(){
            $(".title_ok").click(function(){

                var that = this;
                var tip = $(that).closest('.m_after').find('.tip');

                var m_title = $.trim($(this).prev('.app_title_input').val());
                var length = getByteLen(m_title);

                if(length == 0){                    
                    tip.text('名称不能为空');
                    var st = setTimeout(function(){
                        tip.text('');
                    },2000);
                }else if(length >32){
                    tip.text('字数超出限制');
                    var st = setTimeout(function(){
                        tip.text('');
                    },2000);
                }else if(length <=32){
                    var siteurl = $(this).closest('.app_baseinfo').find('.pc_site').text();
                    var appid = $(this).closest('.app_item').attr('data');

                    $.ajax({
                        type:"POST",
                        url:"/edit_option",
                        data:{
                            "action": "checkstr",
                            badtext: m_title,
                            "siteurl": siteurl,
                            "appid":appid
                        },
                        dataType:'json',
                        success:function(msg){
                            if(msg.ret == 1){
                                tip.text('有敏感词');
                                var st = setTimeout(function(){
                                    tip.text('');
                                },2000);
                            }else{
                                var jsons = {site_title: m_title};

                                //请求修改名称
                                $.ajax({
                                    type: "POST",
                                    url: "/edit_option",
                                       data: {
                                        "action": "set_option",
                                        settings: $.toJSON(jsons),
                                        "siteurl": siteurl,
                                        "appid":appid
                                       },
                                       dataType: 'json', 
                                       success:function(msg){
                                           if(msg.ret == 0){
                                               var app_title_div = $(that).closest('.app_title_div')
                                               app_title_div.find('.m_after').hide();
                                               app_title_div.find('.m_before').css('display','inline-block');
                                               app_title_div.find('.app_title').text(m_title);

                                           }else{
                                               tip.text('服务器繁忙');
                                            var st = setTimeout(function(){
                                                tip.text('');
                                            },2000);
                                           }
                                       }
                                   });
                            }
                        }
                    });
                }
            });

        },
        modifyCancel:function(){
            $(".title_cancel").click(function(){
                $(this).closest(".app_title_div").find(".m_before").css('display','inline-block');
                $(this).closest(".m_after").css('display','none');
            });
        },
        initial:function(){
            this.clickModify();
            this.modifyOk();
            this.modifyCancel();
        }
    };

    var funcs = {
        initial:function(){

            //测试提示
            $(".toTest").hover(function(e){
                $(this).find('.toTest_tip').css('display','block');        
            },function(){
                $(this).find('.toTest_tip').css('display','none');
            });

            $(".testing").hover(function(e){
                $(this).find('.testing_tip').css('display','block');    
            },function(){
                $(this).find('.testing_tip').css('display','none');
            });


            //mtc接口测试
            $(".unmtcCheck").click(function(){
                var appid=$(this).attr("data");
                $.ajax({
                    type: "POST",
                    url:"/mtc_checksite",
                    data:{
                        appid:appid,
                    },
                    success: function(response){
                        console.log(response);
                        response = $.parseJSON(response);
                        if(response.ret === 0){
                           var themtcCheck= $(".unmtcCheck[data='"+appid+"']");
                           themtcCheck.unbind("click");

                           var testingTip = '测试中<div class="webBubble testing_tip" style="display:none">'+
                                        '<div class="bubble-t">'+
                                            '<span id="bubbleClose"></span>'+
                                        '</div>'+
                                        '<div class="bubble-c" id="bubbleCont">'+
                                            '已提交测试，预计分析时间在10分钟左右，欢迎随后查看效果！'+
                                        '</div>'+
                                    '</div>';
                           themtcCheck.html(testingTip);
                           
                           themtcCheck.attr("class","mtcCheck use testing");
                           $(".testing").hover(function(e){
                                $(this).find('.testing_tip').css('display','block');    
                            },function(){
                                $(this).find('.testing_tip').css('display','none');
                            });

                        }else if(response.ret === 1){
                            console.log('系统繁忙,请稍后再试');
                        }
                    }
                });
            });

            //变现管理提示
            $('.ad_notok').hover(function(){
                $(this).find('.ad_tip').show();
            },function(){
                $(this).find('.ad_tip').hide();
            });

            //域名适配提示
            $(".pc_adapt").hover(function(){
                $(this).find('.pc_adapt_tip').css('display','block');
            },function(){
                $(this).find('.pc_adapt_tip').css('display','none');
            });

            //弹出域名适配弹框
            this.adapt();
        },
        adapt:function(){

            $(".adapt_click").click(function(e){
                e.preventDefault();

                var pc_site = $.trim($(this).attr('data'));
                var wap_site = $.trim($(this).closest('.app_item').find('.wap_site').text());

                $("#layer_adapt").show();
                $("#pc_site").text(pc_site);

                if(pc_site.indexOf('http://')<0){
                    pc_site="http://"+pc_site;
                }
                if(wap_site.indexOf('http://')<0){
                    wap_site="http://"+wap_site;
                }

                var jsCode = '<script src="http://siteapp.baidu.com/static/webappservice/uaredirect.js" type="text/javascript"></script><script type="text/javascript">uaredirect("'+wap_site+'","'+pc_site+'");</script>';

                $(".pc_code textarea").val(jsCode);

                baidu.more.copyClipBoard('code_text','copyMask','copy_btn','复制成功','html');
    

            });

            //关闭域名适配
            $("#pc_close_ico").click(function(){
                $("#layer_adapt").hide();        
                $('#copyMask').empty();
            });
        }
    };

    var qrCode = {
        initial:function(){
            var DcodeList=$(".real_qrcode");
            var Dlenth=DcodeList.length;
            for(var i=0; i<Dlenth; i++){
                var curDcod=DcodeList.eq(i)
                var data=curDcod.attr("data");
                
                $(curDcod).qrcode({
                    text: data,
                    width: 80,
                    height:80
                 });
            }

            this.qr_layer();
        },
        qr_layer:function(){
            $(".qr_img").click(function(){
                $(this).closest(".app_info").find(".layer_qrcode").show();
                $(this).closest(".app_info").find(".real_qrcode").show();
            });

            $(".layer_qrcode").click(function(e){
                var target = e.target;
                if(target.className != 'real_qrcode'){
                    $(this).closest(".app_info").find(".real_qrcode").hide();
                    $(this).hide();
                }
            });

        }
    };


    //获取Host的首字母
    function getHostLetter(val){
        
        var reg = /^(http:\/\/)?(www\.)?/ig;
        val = val.replace(reg,'');

        var letter = val.substring(0,1).toUpperCase();
        return letter;
    }

    //获取字符长度，区分中英文
    function getByteLen(val) { 

        var len = 0; 

        for (var i = 0; i < val.length; i++) { 
            if (val[i].match(/[^x00-xff]/ig) != null) //全角 
                len += 2; 
            else 
                len += 1; 
        } 
        return len; 
    }

    function checkIcoSize(evt){

        var files = evt.target.files;

        for (var i = 0, f; f = files[i]; i++) {
            if (!f.type.match('image.*')){
                continue;
            }    

            var reader = new FileReader();
            reader.onload = (function(theFile) {
                return function(e) {                                
                    var src = e.target.result;
                    $("#hidden_img").attr('src',src);
                };
            })(f);
            reader.readAsDataURL(f);            
        }

        $("#hidden_img").load(function(){
            if($(this)[0].height == 117 && $(this)[0].width == 117){
                return true;
            }
            else{
                return false;
            }
        });
        
    }


    myWebapp.initialAll();

    upLoadIco.initial();

    modifyTitle.initial();

    funcs.initial();

    qrCode.initial();

    $.ajaxSetup ({
        cache: false //设置成false将不会从浏览器缓存读取信息
    });
});




