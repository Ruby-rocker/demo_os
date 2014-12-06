//MooTools More, <http://mootools.net/more>. Copyright (c) 2006-2008 Valerio Proietti, <http://mad4milk.net>, MIT Style License.
Fx.Scroll=new Class({Extends:Fx,options:{offset:{x:0,y:0},wheelStops:true},initialize:function(B,A){this.element=this.subject=$(B);this.parent(A);var D=this.cancel.bind(this,false);
if($type(this.element)!="element"){this.element=$(this.element.getDocument().body);}var C=this.element;if(this.options.wheelStops){this.addEvent("start",function(){C.addEvent("mousewheel",D);
},true);this.addEvent("complete",function(){C.removeEvent("mousewheel",D);},true);}},set:function(){var A=Array.flatten(arguments);this.element.scrollTo(A[0],A[1]);
},compute:function(E,D,C){var B=[];var A=2;A.times(function(F){B.push(Fx.compute(E[F],D[F],C));});return B;},start:function(C,H){if(!this.check(arguments.callee,C,H)){return this;
}var E=this.element.getSize(),F=this.element.getScrollSize();var B=this.element.getScroll(),D={x:C,y:H};for(var G in D){var A=F[G]-E[G];if($chk(D[G])){D[G]=($type(D[G])=="number")?D[G].limit(0,A):A;
}else{D[G]=B[G];}D[G]+=this.options.offset[G];}return this.parent([B.x,B.y],[D.x,D.y]);},toTop:function(){return this.start(false,0);},toLeft:function(){return this.start(0,false);
},toRight:function(){return this.start("right",false);},toBottom:function(){return this.start(false,"bottom");},toElement:function(B){var A=$(B).getPosition(this.element);
return this.start(A.x,A.y);}});var SmoothScroll=new Class({Extends:Fx.Scroll,initialize:function(B,C){C=C||document;var E=C.getDocument(),D=C.getWindow();
this.parent(E,B);this.links=(this.options.links)?$$(this.options.links):$$(E.links);var A=D.location.href.match(/^[^#]*/)[0]+"#";this.links.each(function(G){if(G.href.indexOf(A)!=0){return ;
}var F=G.href.substr(A.length);if(F&&$(F)){this.useLink(G,F);}},this);if(!Browser.Engine.webkit419){this.addEvent("complete",function(){D.location.hash=this.anchor;
},true);}},useLink:function(B,A){B.addEvent("click",function(C){this.anchor=A;this.toElement(A);C.stop();}.bind(this));}});