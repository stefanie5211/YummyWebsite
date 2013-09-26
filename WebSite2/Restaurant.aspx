<%@ Page Title="" Language="C#" MasterPageFile="~/WebSite2/MasterPage.master" AutoEventWireup="true" CodeFile="Restaurant.aspx.cs" Inherits="WebSite2_Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        #form1
        {
            height: 2544px;
            font-family: "bradley Hand ITC";
            font-size: xx-large;
            font-weight: bolder;
        }

        #placeholder
        {
            width: 500px;
            height: 500px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <form id="form1" runat="server">
            <script type="text/javascript"
      src="http://maps.googleapis.com/maps/api/js?key=AIzaSyC-WYGMf6ZQK2L7E1eZlInlJVHzipQ5fww&sensor=true">
    </script>
    <script type="text/javascript">
        function initialize() {
            var geocoder = new google.maps.Geocoder();
            var address = "8 Saint Mary St, Boston";
            var latitude = null;
            var longitude = null;
            var marker;
            var LatLng = null;

            geocoder.geocode({ 'address': address }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    latitude = results[0].geometry.location.lat();
                    longitude = results[0].geometry.location.lng();
                    //alert("latitude=" + latitude + ",longitude=" + longitude);
                    LatLng = new google.maps.LatLng(latitude, longitude);
                    if (latitude && longitude) {
                        //marker = new google.maps.Marker("WOcao");//GMarker(new GLatLng(latitude, longitude));
                        var mapOptions = {
                            center: new google.maps.LatLng(latitude, longitude),
                            zoom: 8,
                            mapTypeId: google.maps.MapTypeId.ROADMAP
                        };

                        var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
                        map.setCenter(LatLng);
                        map.setZoom(18);
                        // Set marker also
                        marker = new google.maps.Marker({
                            position: LatLng,
                            map: map,
                            title: address,
                        });

                        //map.addOverlay(marker);
                    }
                }
            });


        }window.onload=initialize;
    </script>
        <script>
            function showPic(whichpic) {
                if (document.getElementById) {
                    document.getElementById('placeholder').src = whichpic.href;
                    document.getElementById('ShowLightBox').href = whichpic.href;
                    if (whichpic.title) {
                        document.getElementById('desc').childNodes[0].nodeValue = whichpic.title;
                    } else {
                        document.getElementById('desc').childNodes[0].nodeValue = whichpic.childNodes[0].nodeValue;
                    } return false;
                } else {
                    return true;
                }
            }
        </script>
        <script>
            /*
	Lightbox JS: Fullsize Image Overlays 
	by Lokesh Dhakar - http://www.huddletogether.com

	For more information on this script, visit:
	http://huddletogether.com/projects/lightbox/

	Licensed under the Creative Commons Attribution 2.5 License - http://creativecommons.org/licenses/by/2.5/
	(basically, do anything you want, just leave my name and link)
	
	Table of Contents
	-----------------
	Configuration
	
	Functions
	- getPageScroll()
	- getPageSize()
	- pause()
	- getKey()
	- listenKey()
	- showLightbox()
	- hideLightbox()
	- initLightbox()
	- addLoadEvent()
	
	Function Calls
	- addLoadEvent(initLightbox)

*/



            //
            // Configuration
            //

            // If you would like to use a custom loading image or close button reference them in the next two lines.
            var loadingImage = 'loading.gif';
            var closeButton = 'close.gif';





            //
            // getPageScroll()
            // Returns array with x,y page scroll values.
            // Core code from - quirksmode.org
            //
            function getPageScroll() {

                var yScroll;

                if (self.pageYOffset) {
                    yScroll = self.pageYOffset;
                } else if (document.documentElement && document.documentElement.scrollTop) {	 // Explorer 6 Strict
                    yScroll = document.documentElement.scrollTop;
                } else if (document.body) {// all other Explorers
                    yScroll = document.body.scrollTop;
                }

                arrayPageScroll = new Array('', yScroll)
                return arrayPageScroll;
            }



            //
            // getPageSize()
            // Returns array with page width, height and window width, height
            // Core code from - quirksmode.org
            // Edit for Firefox by pHaez
            //
            function getPageSize() {

                var xScroll, yScroll;

                if (window.innerHeight && window.scrollMaxY) {
                    xScroll = document.body.scrollWidth;
                    yScroll = window.innerHeight + window.scrollMaxY;
                } else if (document.body.scrollHeight > document.body.offsetHeight) { // all but Explorer Mac
                    xScroll = document.body.scrollWidth;
                    yScroll = document.body.scrollHeight;
                } else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
                    xScroll = document.body.offsetWidth;
                    yScroll = document.body.offsetHeight;
                }

                var windowWidth, windowHeight;
                if (self.innerHeight) {	// all except Explorer
                    windowWidth = self.innerWidth;
                    windowHeight = self.innerHeight;
                } else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
                    windowWidth = document.documentElement.clientWidth;
                    windowHeight = document.documentElement.clientHeight;
                } else if (document.body) { // other Explorers
                    windowWidth = document.body.clientWidth;
                    windowHeight = document.body.clientHeight;
                }

                // for small pages with total height less then height of the viewport
                if (yScroll < windowHeight) {
                    pageHeight = windowHeight;
                } else {
                    pageHeight = yScroll;
                }

                // for small pages with total width less then width of the viewport
                if (xScroll < windowWidth) {
                    pageWidth = windowWidth;
                } else {
                    pageWidth = xScroll;
                }


                arrayPageSize = new Array(pageWidth, pageHeight, windowWidth, windowHeight)
                return arrayPageSize;
            }


            //
            // pause(numberMillis)
            // Pauses code execution for specified time. Uses busy code, not good.
            // Code from http://www.faqts.com/knowledge_base/view.phtml/aid/1602
            //
            function pause(numberMillis) {
                var now = new Date();
                var exitTime = now.getTime() + numberMillis;
                while (true) {
                    now = new Date();
                    if (now.getTime() > exitTime)
                        return;
                }
            }

            //
            // getKey(key)
            // Gets keycode. If 'x' is pressed then it hides the lightbox.
            //

            function getKey(e) {
                if (e == null) { // ie
                    keycode = event.keyCode;
                } else { // mozilla
                    keycode = e.which;
                }
                key = String.fromCharCode(keycode).toLowerCase();

                if (key == 'x') { hideLightbox(); }
            }


            //
            // listenKey()
            //
            function listenKey() { document.onkeypress = getKey; }


            //
            // showLightbox()
            // Preloads images. Pleaces new image in lightbox then centers and displays.
            //
            function showLightbox(objLink) {
                // prep objects
                var objOverlay = document.getElementById('overlay');
                var objLightbox = document.getElementById('lightbox');
                var objCaption = document.getElementById('lightboxCaption');
                var objImage = document.getElementById('lightboxImage');
                var objLoadingImage = document.getElementById('loadingImage');
                var objLightboxDetails = document.getElementById('lightboxDetails');


                var arrayPageSize = getPageSize();
                var arrayPageScroll = getPageScroll();

                // center loadingImage if it exists
                if (objLoadingImage) {
                    objLoadingImage.style.top = (arrayPageScroll[1] + ((arrayPageSize[3] - 35 - objLoadingImage.height) / 2) + 'px');
                    objLoadingImage.style.left = (((arrayPageSize[0] - 20 - objLoadingImage.width) / 2) + 'px');
                    objLoadingImage.style.display = 'block';
                }

                // set height of Overlay to take up whole page and show
                objOverlay.style.height = (arrayPageSize[1] + 'px');
                objOverlay.style.display = 'block';

                // preload image
                imgPreload = new Image();

                imgPreload.onload = function () {
                    objImage.src = objLink.href;

                    // center lightbox and make sure that the top and left values are not negative
                    // and the image placed outside the viewport
                    var lightboxTop = arrayPageScroll[1] + ((arrayPageSize[3] - 35 - imgPreload.height) / 2);
                    var lightboxLeft = ((arrayPageSize[0] - 20 - imgPreload.width) / 2);

                    objLightbox.style.top = (lightboxTop < 0) ? "0px" : lightboxTop + "px";
                    objLightbox.style.left = (lightboxLeft < 0) ? "0px" : lightboxLeft + "px";


                    objLightboxDetails.style.width = imgPreload.width + 'px';

                    if (objLink.getAttribute('title')) {
                        objCaption.style.display = 'block';
                        //objCaption.style.width = imgPreload.width + 'px';
                        objCaption.innerHTML = objLink.getAttribute('title');
                    } else {
                        objCaption.style.display = 'none';
                    }

                    // A small pause between the image loading and displaying is required with IE,
                    // this prevents the previous image displaying for a short burst causing flicker.
                    if (navigator.appVersion.indexOf("MSIE") != -1) {
                        pause(250);
                    }

                    if (objLoadingImage) { objLoadingImage.style.display = 'none'; }

                    // Hide select boxes as they will 'peek' through the image in IE
                    selects = document.getElementsByTagName("select");
                    for (i = 0; i != selects.length; i++) {
                        selects[i].style.visibility = "hidden";
                    }


                    objLightbox.style.display = 'block';

                    // After image is loaded, update the overlay height as the new image might have
                    // increased the overall page height.
                    arrayPageSize = getPageSize();
                    objOverlay.style.height = (arrayPageSize[1] + 'px');

                    // Check for 'x' keypress
                    listenKey();

                    return false;
                }

                imgPreload.src = objLink.href;

            }





            //
            // hideLightbox()
            //
            function hideLightbox() {
                // get objects
                objOverlay = document.getElementById('overlay');
                objLightbox = document.getElementById('lightbox');

                // hide lightbox and overlay
                objOverlay.style.display = 'none';
                objLightbox.style.display = 'none';

                // make select boxes visible
                selects = document.getElementsByTagName("select");
                for (i = 0; i != selects.length; i++) {
                    selects[i].style.visibility = "visible";
                }

                // disable keypress listener
                document.onkeypress = '';
            }




            //
            // initLightbox()
            // Function runs on window load, going through link tags looking for rel="lightbox".
            // These links receive onclick events that enable the lightbox display for their targets.
            // The function also inserts html markup at the top of the page which will be used as a
            // container for the overlay pattern and the inline image.
            //
            function initLightbox() {

                if (!document.getElementsByTagName) { return; }
                var anchors = document.getElementsByTagName("a");

                // loop through all anchor tags
                for (var i = 0; i < anchors.length; i++) {
                    var anchor = anchors[i];

                    if (anchor.getAttribute("href") && (anchor.getAttribute("rel") == "lightbox")) {
                        anchor.onclick = function () { showLightbox(this); return false; }
                    }
                }

                // the rest of this code inserts html at the top of the page that looks like this:
                //
                // <div id="overlay">
                //		<a href="#" onclick="hideLightbox(); return false;"><img id="loadingImage" /></a>
                //	</div>
                // <div id="lightbox">
                //		<a href="#" onclick="hideLightbox(); return false;" title="Click anywhere to close image">
                //			<img id="closeButton" />		
                //			<img id="lightboxImage" />
                //		</a>
                //		<div id="lightboxDetails">
                //			<div id="lightboxCaption"></div>
                //			<div id="keyboardMsg"></div>
                //		</div>
                // </div>

                var objBody = document.getElementsByTagName("body").item(0);

                // create overlay div and hardcode some functional styles (aesthetic styles are in CSS file)
                var objOverlay = document.createElement("div");
                objOverlay.setAttribute('id', 'overlay');
                objOverlay.onclick = function () { hideLightbox(); return false; }
                objOverlay.style.display = 'none';
                objOverlay.style.position = 'absolute';
                objOverlay.style.top = '0';
                objOverlay.style.left = '0';
                objOverlay.style.zIndex = '90';
                objOverlay.style.width = '100%';
                objBody.insertBefore(objOverlay, objBody.firstChild);

                var arrayPageSize = getPageSize();
                var arrayPageScroll = getPageScroll();

                // preload and create loader image
                var imgPreloader = new Image();

                // if loader image found, create link to hide lightbox and create loadingimage
                imgPreloader.onload = function () {

                    var objLoadingImageLink = document.createElement("a");
                    objLoadingImageLink.setAttribute('href', '#');
                    objLoadingImageLink.onclick = function () { hideLightbox(); return false; }
                    objOverlay.appendChild(objLoadingImageLink);

                    var objLoadingImage = document.createElement("img");
                    objLoadingImage.src = loadingImage;
                    objLoadingImage.setAttribute('id', 'loadingImage');
                    objLoadingImage.style.position = 'absolute';
                    objLoadingImage.style.zIndex = '150';
                    objLoadingImageLink.appendChild(objLoadingImage);

                    imgPreloader.onload = function () { };	//	clear onLoad, as IE will flip out w/animated gifs

                    return false;
                }

                imgPreloader.src = loadingImage;

                // create lightbox div, same note about styles as above
                var objLightbox = document.createElement("div");
                objLightbox.setAttribute('id', 'lightbox');
                objLightbox.style.display = 'none';
                objLightbox.style.position = 'absolute';
                objLightbox.style.zIndex = '100';
                objBody.insertBefore(objLightbox, objOverlay.nextSibling);

                // create link
                var objLink = document.createElement("a");
                objLink.setAttribute('href', '#');
                objLink.setAttribute('title', 'Click to close');
                objLink.onclick = function () { hideLightbox(); return false; }
                objLightbox.appendChild(objLink);

                // preload and create close button image
                var imgPreloadCloseButton = new Image();

                // if close button image found, 
                imgPreloadCloseButton.onload = function () {

                    var objCloseButton = document.createElement("img");
                    objCloseButton.src = closeButton;
                    objCloseButton.setAttribute('id', 'closeButton');
                    objCloseButton.style.position = 'absolute';
                    objCloseButton.style.zIndex = '200';
                    objLink.appendChild(objCloseButton);

                    return false;
                }

                imgPreloadCloseButton.src = closeButton;

                // create image
                var objImage = document.createElement("img");
                objImage.setAttribute('id', 'lightboxImage');
                objLink.appendChild(objImage);

                // create details div, a container for the caption and keyboard message
                var objLightboxDetails = document.createElement("div");
                objLightboxDetails.setAttribute('id', 'lightboxDetails');
                objLightbox.appendChild(objLightboxDetails);

                // create caption
                var objCaption = document.createElement("div");
                objCaption.setAttribute('id', 'lightboxCaption');
                objCaption.style.display = 'none';
                objLightboxDetails.appendChild(objCaption);

                // create keyboard message
                var objKeyboardMsg = document.createElement("div");
                objKeyboardMsg.setAttribute('id', 'keyboardMsg');
                objKeyboardMsg.innerHTML = 'press <a href="#" onclick="hideLightbox(); return false;"><kbd>x</kbd></a> to close';
                objLightboxDetails.appendChild(objKeyboardMsg);


            }




            //
            // addLoadEvent()
            // Adds event to window.onload without overwriting currently assigned onload functions.
            // Function found at Simon Willison's weblog - http://simon.incutio.com/
            //
            function addLoadEvent(func) {
                var oldonload = window.onload;
                if (typeof window.onload != 'function') {
                    window.onload = func;
                } else {
                    window.onload = function () {
                        oldonload();
                        func();
                    }
                }

            }
            addLoadEvent(initLightbox);	// run initLightbox onLoad
        </script>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Top 2 [Uname], [Content], [Date], [Rate] FROM [tb_Review] WHERE ([Rname] = @Rname) ORDER BY [ID] DESC">
            <SelectParameters>
                <asp:SessionParameter Name="Rname" SessionField="Restaurantname" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <div class="restname">
            <asp:Image ID="Image1" runat="server" Height="233px" Width="310px" />
            <br />
            <br />
            <br />
        </div>
        <div class="restaurantintro" style=" height:233px">
            <asp:Label ID="Label4" runat="server" Text="Restaurant: " CssClass="intro"></asp:Label>
            <asp:Label ID="LabelRname" runat="server" Text="RestaurantName" CssClass="intro"></asp:Label><br />
            <asp:Label ID="Label5" runat="server" Text="Contact: " CssClass="intro"></asp:Label>
            <asp:Label ID="LabelContact" runat="server" Text="RestaurantContact" CssClass="intro"></asp:Label><br />
            <asp:Label ID="Label6" runat="server" Text="Address: " CssClass="intro"></asp:Label>
            <asp:Label ID="LabelAddress" runat="server" Text="RestaurantAddress" CssClass="intro"></asp:Label><br />
            <asp:Label ID="Label7" runat="server" Text="Cuisine: " CssClass="intro"></asp:Label>
            <asp:Label ID="LabelCuisine" runat="server" Text="RestaurantCuisine" CssClass="intro"></asp:Label><br />
            <asp:Label ID="Label8" runat="server" Text="Rate: " CssClass="intro"></asp:Label>
            <asp:Label ID="LabelRate" runat="server" Text="RestaurantRate" CssClass="intro"></asp:Label><br />
        </div>
            <asp:Label ID="Label9" runat="server" Text="Description: " CssClass="intro"></asp:Label>
            <asp:Label ID="LabelDescription" runat="server" Text="RestaurantDescription" CssClass="intro"></asp:Label>
        
            <div id="album" >
                <link href="CSS%20style/album.css" rel="stylesheet" />
                <div id="pic"">
                    <h1 style="font-size: 1.5em; text-align: center; padding: 1em; height: 1px; margin-left:auto;margin-right:auto">Yummy! Album</h1>
                    <a href="Image/restaurant/Mc/mcdonalds-Angus-Deluxe-Snack-Wrap.png" rel="lightbox" id="ShowLightBox">
                        <img src="Image/restaurant/Mc/mcdonalds-Angus-Deluxe-Snack-Wrap.png" alt="点击查看完全尺寸" id="placeholder" style="margin-left:auto;margin-right:auto" /></a>
                </div>
                <p id="desc">McDonald's Hot Food</p>
                <div id="thumbs">
                    <ul>
                        <li><a onclick="return showPic(this);" href="Image/restaurant/Mc/mcdonalds-Angus-Deluxe-Snack-Wrap.png" title="Deluxe-Snack-Wrap">
                            <img src="Image/restaurant/Mc/mcdonalds-Angus-Deluxe-Snack-Wrapsssssssssss.png" alt="Mc" /></a></li>
                        <li><a onclick="return showPic(this);" href="Image/restaurant/Mc/mcdonalds-Big-Mac.png" title="Lovely Baby">
                            <img src="Image/restaurant/Mc/mcdonalds-Big-Macsssss.png" alt="Mc" /></a></li>
                        <li><a onclick="return showPic(this);" href="Image/restaurant/Mc/mcdonalds-Fish-McBites-Regular-Size.png" title="Fish-McBites">
                            <img src="Image/restaurant/Mc/mcdonalds-Fish-McBites-Regular-Sizessssssss.png" alt="Mc" /></a></li>
                        <li><a onclick="return showPic(this);" href="Image/restaurant/Mc/mcdonalds-Premium-Bacon-Ranch-Salad-with-Crispy-Chicken.png" title="Bacon-Ranch-Salad">
                            <img src="Image/restaurant/Mc/mcdonalds-Premium-Bacon-Ranch-Salad-with-Crispy-Chickensssssssss.png" alt="Mc" /></a></li>
                        <li><a onclick="return showPic(this);" href="Image/restaurant/Mc/mcdonalds-Premium-Roast-Iced-Coffee-Small.png" title="Roast-Iced-Coffee">
                            <img src="Image/restaurant/Mc/mcdonalds-Premium-Roast-Iced-Coffee-Smallssssssssss.png" alt="Mc" /></a></li>
                        <li><a onclick="return showPic(this);" href="Image/restaurant/Mc/mcdonalds-Small-French-Fries.png" title="French-Fries">
                            <img src="Image/restaurant/Mc/mcdonalds-Small-French-Friessssssssssssss.png" alt="Mc" /></a></li>
                        <li><a onclick="return showPic(this);" href="Image/restaurant/Mc/mcdonalds-Vanilla-Reduced-Fat-Ice-Cream-Cone.png" title="French-Fries">
                            <img src="Image/restaurant/Mc/mcdonalds-Vanilla-Reduced-Fat-Ice-Cream-Conesssssssssss.png" alt="Mc" /></a></li>
                        <li><a onclick="return showPic(this);" href="Image/restaurant/Mc/mcdonalds-Bacon-Egg-Cheese-Biscuit-Regular-Size-Biscuit.png" title="French-Fries">
                            <img src="Image/restaurant/Mc/mcdonalds-Bacon-Egg-Cheese-Biscuit-Regular-Size-Biscuitsssssssssssssss.png" alt="Mc" /></a></li>
                        <li><a onclick="return showPic(this);" href="Image/restaurant/Mc/mcdonalds-Fish-McBites-Happy-Meals.png" title="French-Fries">
                            <img src="Image/restaurant/Mc/mcdonalds-Fish-McBites-Happy-Mealssssssssss.png" alt="Mc" /></a></li>
                        <li><a onclick="return showPic(this);" href="Image/restaurant/Mc/mcdonalds-McFlurry-with-MMS-Candies-12-fl-oz-cup.png" title="French-Fries">
                            <img src="Image/restaurant/Mc/mcdonalds-McFlurry-with-MMS-Candies-12-fl-oz-cupssssssssssss.png" alt="Mc" /></a></li>
                    </ul>
                </div>
            </div>
        <br />
        <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" GridLines="Horizontal" Height="16px" RepeatColumns="1" RepeatDirection="Horizontal" Width="600px" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center">
            <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
            <FooterTemplate>
                <asp:Button ID="ButtonMore" runat="server" CssClass="Button"  Height="32px" Text="Find more" Width="123px" OnClick="ButtonMore_Click" />
                <br />

            </FooterTemplate>
            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" />
            <HeaderTemplate>
                Recent Reviews:
            </HeaderTemplate>
            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
            <ItemTemplate>
                User:
                <asp:Label ID="UnameLabel" runat="server" Text='<%# Eval("Uname") %>' />
                <br />
                Content:
                <asp:Label ID="ContentLabel" runat="server" Text='<%# Eval("Content") %>' />
                <br />
                Date:
                <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("Date") %>' />
                <br />
                Rate:
                <asp:Label ID="RateLabel" runat="server" Text='<%# Eval("Rate") %>' />
                <br />
                <br />
            </ItemTemplate>
        </asp:DataList>
        <div id="map_canvas" onload="initialize()" style="width:600px;height:500px;margin-left:auto;margin-right:auto"></div>
        
        <div style="height:128px;width:600px;margin-left:auto; margin-right:auto;">
            <asp:Label ID="LabelReviewContent" runat="server" Text="Your Review:"></asp:Label><br />
            <asp:TextBox ID="TextBox1" runat="server" Height="95px" Width="599px" TextMode="MultiLine"></asp:TextBox><br />
            <asp:Label ID="LabelReviewRate" runat="server" Text="Your Rate:(with full of 5 credits)"></asp:Label>
            <asp:TextBox ID="TextBoxRate" runat="server" Height="25px" Width="75px"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" CssClass="Button"  Height="32px" Text="Comment" Width="123px" OnClick="Button1_Click" />
        </div>
    </form>
</asp:Content>

