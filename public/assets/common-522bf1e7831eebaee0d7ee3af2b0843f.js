/**
 * COMMON DHTML FUNCTIONS
 * These are handy functions I use all the time.
 *
 * By Seth Banks (webmaster at subimage dot com)
 * http://www.subimage.com/
 *
 * Up to date code can be found at http://www.subimage.com/dhtml/
 *
 * This code is free for you to use anywhere, just keep this comment block.
 */
/**
 * X-browser event handler attachment and detachment
 * TH: Switched first true to false per http://www.onlinetools.org/articles/unobtrusivejavascript/chapter4.html
 *
 * @argument obj - the object to attach event to
 * @argument evType - name of the event - DONT ADD "on", pass only "mouseover", etc
 * @argument fn - function to call
 */
function addEvent(a,b,c){if(a.addEventListener)return a.addEventListener(b,c,!1),!0;if(a.attachEvent){var d=a.attachEvent("on"+b,c);return d}return!1}function removeEvent(a,b,c,d){if(a.removeEventListener)return a.removeEventListener(b,c,d),!0;if(a.detachEvent){var e=a.detachEvent("on"+b,c);return e}alert("Handler could not be removed")}function getViewportHeight(){return window.innerHeight!=window.undefined?window.innerHeight:document.compatMode=="CSS1Compat"?document.documentElement.clientHeight:document.body?document.body.clientHeight:window.undefined}function getViewportWidth(){var a=17,b=null;if(window.innerWidth!=window.undefined)return window.innerWidth;if(document.compatMode=="CSS1Compat")return document.documentElement.clientWidth;if(document.body)return document.body.clientWidth}function getScrollTop(){if(self.pageYOffset)return self.pageYOffset;if(document.documentElement&&document.documentElement.scrollTop)return document.documentElement.scrollTop;if(document.body)return document.body.scrollTop}function getScrollLeft(){if(self.pageXOffset)return self.pageXOffset;if(document.documentElement&&document.documentElement.scrollLeft)return document.documentElement.scrollLeft;if(document.body)return document.body.scrollLeft};