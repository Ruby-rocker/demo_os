//-------------------------------------------------------------------------------------
//          Pure Javascript Spell Checker
//          By: Erobo Software
//          http://www.erobo.net 
//          Copyright (c) 2010-2011 Erobo Software
//          
//     ********************************************************************************     
//     *     Released under the GNU General Public License                            *
//     *     This program is free software: you can redistribute it and/or modify     *
//     *     it under the terms of the GNU General Public License as published by     *
//     *     the Free Software Foundation, either version 3 of the License, or        *
//     *     (at your option) any later version.                                      *
//     *                                                                              *
//     *     This program is distributed in the hope that it will be useful,          *
//     *     but WITHOUT ANY WARRANTY; without even the implied warranty of           *
//     *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *
//     *     GNU General Public License for more details.                             *
//     *                                                                              *
//     *     You should have received a copy of the GNU General Public License        *
//     *     along with this program.  If not, see <http://www.gnu.org/licenses/>.    *
//     ********************************************************************************
//
//-------------------------------------------------------------------------------------

function PureSpellChecker(textAreaID, languageName, imgPath, dicWordsPath) {
  if (textAreaID == null || languageName == null) return;
  this.textAreaId = textAreaID;
  this.spellCheckId = "Checker" + Math.floor(Math.random() * 200);
  this.preferredLanguage = languageName.toLowerCase();
  this.webmasterEmail = "service@yoursite.com";
  this.checkGrammar = true;
  this.imgPath = imgPath;
  this.dicWordsPath = dicWordsPath;
  this.vWinChrWidth = 550;
  this.vWinChrHeight = 240;
  var vvWinChrParam = "width=" + this.vWinChrWidth + ",height=" + this.vWinChrHeight;
  vvWinChrParam = vvWinChrParam + ",status=no,resizable=no,top=200,left=200";
  this.vWinChrParam = vvWinChrParam;
  this.vWinChr = "";
  this.docText = "";
  this.progressInterval = 0;
  this.progressTotal = 0;
  this.progressCounter = 1;
  this.processStarted = false;
  this.lan = "";
  this.cylinder = document.getElementById("cylinder");
  this.mySplitTxt = Array();
  this.currIdx = 0;
  this.errorsFound = 0;
  this.wordsCorrected = 0;
  this.totalWords = 0;
  this.SrcCylinder = "";
  this.dicLength = 0;

  this.preloadDic = false;

  //pattern declaration
  if (this.preferredLanguage == 'english') {
    this.pattA = /[^a-zA-Z 0-9]/g; this.pattB = /[a-z 0-9]/; this.pattC = /[A-Z]/;
    this.pattD = /[a-zA-Z]/; this.pattE = /[a-z]/; this.pattF = "[^a-zA-Z 0-9]*";
    this.pattG = /[^a-zA-Z 0-9 \' \- \, \. \( \) \" \; \: \? \!]+/g;
  }
  if (this.preferredLanguage == 'spanish') {
    this.pattA = /[^a-zA-Z \ñ \á \é \í \ó \ú \Ñ \Á \É \Í \Ó \Ú 0-9]/g; this.pattB = /[a-z \ñ \á \é \í \ó \ú 0-9]/;
    this.pattC = /[A-Z \Ñ \Á \É \Í \Ó \Ú]/; this.pattD = /[a-zA-Z \ñ \á \é \í \ó \ú \Ñ \Á \É \Í \Ó \Ú]/;
    this.pattE = /[a-z \ñ \á \é \í \ó \ú]/; this.pattF = "[^a-zA-Z \ñ \á \é \í \ó \ú \Ñ \Á \É \Í \Ó \Ú 0-9]*";
    this.pattG = /[^a-zA-Z \ñ \á \é \í \ó \ú \Ñ \Á \É \Í \Ó \Ú 0-9 \' \- \, \. \( \) \" \; \: \? \!]+/g;
  }
  if (this.preferredLanguage == 'portuguese') {
    this.pattA = /[^a-zA-Z \á \ã \à \â \ê \é \è \í \ó \ô \õ \ô \ú \ç \Á \Ã \À \Â \Ê \É \È \Í \Ó \Ô \Õ \Ô \Ú \Ç 0-9]/g;
    this.pattB = /[a-z \á \ã \à \â \ê \é \è \í \ó \ô \õ \ô \ú \ç 0-9]/; this.pattC = /[A-Z \Á \Ã \À \Â \Ê \É \È \Í \Ó \Ô \Õ \Ô \Ú \Ç]/;
    this.pattD = /[a-zA-Z \á \ã \à \â \ê \é \è \í \ó \ô \õ \ô \ú \ç \Á \Ã \À \Â \Ê \É \È \Í \Ó \Ô \Õ \Ô \Ú \Ç]/;
    this.pattE = /[a-z \á \ã \à \â \ê \é \è \í \ó \ô \õ \ô \ú \ç]/;
    this.pattF = "[^a-zA-Z \á \ã \à \â \ê \é \è \í \ó \ô \õ \ô \ú \ç \Á \Ã \À \Â \Ê \É \È \Í \Ó \Ô \Õ \Ô \Ú \Ç 0-9]*";
    this.pattG = /[^a-zA-Z \á \ã \à \â \ê \é \è \í \ó \ô \õ \ô \ú \ç \Á \Ã \À \Â \Ê \É \È \Í \Ó \Ô \Õ \Ô \Ú \Ç 0-9 \' \- \, \. \( \) \" \; \: \? \!]+/g;
  }
  if (this.preferredLanguage == 'french') {
    this.pattA = /[^a-zA-Z \à \â \ç \é \è \ê \ë \î \ï \ô \û \ù \ü \ÿ \æ \œ \À \Â \Ç \É \È \Ê \Ë \Î \Ï \Ô \Û \Ù \Ü \Ÿ \Æ \Œ 0-9]/g;
    this.pattB = /[a-z \à \â \ç \é \è \ê \ë \î \ï \ô \û \ù \ü \ÿ \æ \œ 0-9]/; this.pattC = /[A-Z \À \Â \Ç \É \È \Ê \Ë \Î \Ï \Ô \Û \Ù \Ü \Ÿ \Æ \Œ]/;
    this.pattD = /[a-zA-Z \à \â \ç \é \è \ê \ë \î \ï \ô \û \ù \ü \ÿ \æ \œ \À \Â \Ç \É \È \Ê \Ë \Î \Ï \Ô \Û \Ù \Ü \Ÿ \Æ \Œ]/;
    this.pattE = /[a-z \à \â \ç \é \è \ê \ë \î \ï \ô \û \ù \ü \ÿ \æ \œ]/;
    this.pattF = "[^a-zA-Z \à \â \ç \é \è \ê \ë \î \ï \ô \û \ù \ü \ÿ \æ \œ \À \Â \Ç \É \È \Ê \Ë \Î \Ï \Ô \Û \Ù \Ü \Ÿ \Æ \Œ 0-9]*";
    this.pattG = /[^a-zA-Z \à \â \ç \é \è \ê \ë \î \ï \ô \û \ù \ü \ÿ \æ \œ \À \Â \Ç \É \È \Ê \Ë \Î \Ï \Ô \Û \Ù \Ü \Ÿ \Æ \Œ 0-9 \' \- \, \. \( \) \" \; \: \? \!]+/g;
  }
  if (this.preferredLanguage == 'dutch') {
    this.pattA = /[^a-zA-Z \ä \à \â \è \é \ë \ê \ï \î \ö \ó \ô \ü \û \ç \Ä \À \Â \È \É \Ë \Ê \Ï \Î \Ö \Ó \Ô \Ü \Û \Ç 0-9]/g;
    this.pattB = /[a-z \ä \à \â \è \é \ë \ê \ï \î \ö \ó \ô \ü \û \ç 0-9]/; this.pattC = /[A-Z \Ä \À \Â \È \É \Ë \Ê \Ï \Î \Ö \Ó \Ô \Ü \Û \Ç]/;
    this.pattD = /[a-zA-Z \ä \à \â \è \é \ë \ê \ï \î \ö \ó \ô \ü \û \ç \Ä \À \Â \È \É \Ë \Ê \Ï \Î \Ö \Ó \Ô \Ü \Û \Ç]/;
    this.pattE = /[a-z \ä \à \â \è \é \ë \ê \ï \î \ö \ó \ô \ü \û \ç]/;
    this.pattF = "[^a-zA-Z \ä \à \â \è \é \ë \ê \ï \î \ö \ó \ô \ü \û \ç \Ä \À \Â \È \É \Ë \Ê \Ï \Î \Ö \Ó \Ô \Ü \Û \Ç 0-9]*";
    this.pattG = /[^a-zA-Z \ä \à \â \è \é \ë \ê \ï \î \ö \ó \ô \ü \û \ç \Ä \À \Â \È \É \Ë \Ê \Ï \Î \Ö \Ó \Ô \Ü \Û \Ç 0-9 \' \- \, \. \( \) \" \; \: \? \!]+/g;
  }
  if (this.preferredLanguage == 'deutsch') {
    this.pattA = /[^a-zA-Z \á \à \ä \â \å \é \ê \è \ë \í \î \ó \ô \ö \ú \ü \û \œ \ñ \ø \ç \Á \À \Ä \Â \Å \É \Ê \È \Ë \Í \Î \Ó \Ô \Ö \Ú \Ü \Û \Œ \Ñ \Ø \Ç \ß 0-9]/g;
    this.pattB = /[a-z \á \à \ä \â \å \é \ê \è \ë \í \î \ó \ô \ö \ú \ü \û \œ \ñ \ø \ç \ß 0-9]/;
    this.pattC = /[A-Z \Á \À \Ä \Â \Å \É \Ê \È \Ë \Í \Î \Ó \Ô \Ö \Ú \Ü \Û \Œ \Ñ \Ø \Ç \ß]/;
    this.pattD = /[a-zA-Z \á \à \ä \â \å \é \ê \è \ë \í \î \ó \ô \ö \ú \ü \û \œ \ñ \ø \ç \Á \À \Ä \Â \Å \É \Ê \È \Ë \Í \Î \Ó \Ô \Ö \Ú \Ü \Û \Œ \Ñ \Ø \Ç \ß]/;
    this.pattE = /[a-z \á \à \ä \â \å \é \ê \è \ë \í \î \ó \ô \ö \ú \ü \û \œ \ñ \ø \ç \ß]/;
    this.pattF = "[^a-zA-Z \á \à \ä \â \å \é \ê \è \ë \í \î \ó \ô \ö \ú \ü \û \œ \ñ \ø \ç \Á \À \Ä \Â \Å \É \Ê \È \Ë \Í \Î \Ó \Ô \Ö \Ú \Ü \Û \Œ \Ñ \Ø \Ç \ß 0-9]*";
    this.pattG = /[^a-zA-Z \á \à \ä \â \å \é \ê \è \ë \í \î \ó \ô \ö \ú \ü \û \œ \ñ \ø \ç \Á \À \Ä \Â \Å \É \Ê \È \Ë \Í \Î \Ó \Ô \Ö \Ú \Ü \Û \Œ \Ñ \Ø \Ç \ß 0-9 \' \- \, \. \( \) \" \; \: \? \!]+/g;
  }
  if (this.preferredLanguage == 'italian') {
    this.pattA = /[^a-zA-Z 0-9]/g; this.pattB = /[a-z 0-9]/; this.pattC = /[A-Z]/;
    this.pattD = /[a-zA-Z]/; this.pattE = /[a-z]/; this.pattF = "[^a-zA-Z 0-9]*";
    this.pattG = /[^a-zA-Z 0-9 \' \- \, \. \( \) \" \; \: \? \!]+/g;
  }
  //end of pattern declaration

}

// Set the spell checker object functions
PureSpellChecker.formatInputString = formatInputStringX;
PureSpellChecker.escapeVal = escapeValX;
PureSpellChecker.splitHTMLTags = splitHTMLTagsX;
PureSpellChecker.replaceTagsWithSymbol = replaceTagsWithSymbolX;
PureSpellChecker.isInArray = isInArrayX;
PureSpellChecker.simpleSplit = simpleSplitX;
PureSpellChecker.isTag = isTagX;
PureSpellChecker.hasError = hasErrorX;
PureSpellChecker.getError = getErrorX;
PureSpellChecker.populateSuggestions = populateSuggestionsX;
PureSpellChecker.disableAll = disableAllX;
PureSpellChecker.enableAll = enableAllX;
PureSpellChecker.replaceErrorTags = replaceErrorTagsX

//------------------------------------------
//Format the Input String
//@param1 raw text data from user's input	
//------------------------------------------
function formatInputStringX(theText) {
  var tempTextArr = Array();
  var tempTextWrd = "";
  var theTextArr = Array();

  var searchText = "";

  if (theText.indexOf(" ") != -1) {
    //Clean white space, handle apostrophes, double quotes and
    //convert to lower case
    theTextArr = theText.split(" ");
    for (var x = 0; x < theTextArr.length; x++) {
      if (theTextArr[x] != "" && isNaN(theTextArr[x])) {
        tempTextWrd = theTextArr[x];
        searchText = searchText + tempTextWrd.toLowerCase() + " ";
      }
    }
    searchText = searchText.substring(0, searchText.length - 1);
  }
  else {
    tempTextWrd = theText;
    searchText = tempTextWrd;
  }
  return searchText;
}

//------------------------------------------
//Escape values from a String method
//@param1 raw text data from user's input	
//------------------------------------------
function escapeValX(thisText) {
  thisText = escape(thisText);
  for (i = 0; i < thisText.length; i++) {
    if (thisText.indexOf("%0D%0A") > -1) {
      thisText = thisText.replace("%0D%0A", " ");
    }
    else if (thisText.indexOf("%0A") > -1) {
      thisText = thisText.replace("%0A", " ");
    }
    else if (thisText.indexOf("%0D") > -1) {
      thisText = thisText.replace("%0D", " ");
    }
  }
  return unescape(thisText);
}

//------------------------------------------
//Split HMTL Tags from a string method
//@param1 raw text data from user's input
//@param2 include tags on return array	
//------------------------------------------
function splitHTMLTagsX(thisText, includeTags) {
  var splittedTextL = thisText.split("<");
  var splittedTextR = Array();
  var newSplittedText = Array();
  var newSplittedIdx = 0;
  var prevCharR = "";

  var prevCharL = "";

  if (splittedTextL.length > 1) {
    for (var k = 0; k < splittedTextL.length; k++) {
      if (splittedTextL[k].length > 0) {
        if (k > 0) {
          splittedTextL[k] = "<" + splittedTextL[k];
        }
        if (splittedTextL[k].indexOf(">") > -1) {
          splittedTextR = splittedTextL[k].split(">");
          for (var z = 0; z < splittedTextR.length; z++) {
            if (splittedTextR[z].length > 0) {
              if (z + 1 < splittedTextR.length) {
                splittedTextR[z] = splittedTextR[z] + ">";
                prevCharR = prevCharR + splittedTextR[z];
              } else {
                prevCharR = prevCharR + splittedTextR[z];
              }
              if (splittedTextR[z].indexOf("<") != -1) {
                if (includeTags == true) {
                  if (prevCharL.length > 0) {
                    newSplittedText[newSplittedIdx] = prevCharL;
                    newSplittedIdx++;
                    prevCharL = "";
                  }
                  newSplittedText[newSplittedIdx] = splittedTextR[z];
                  newSplittedIdx++;
                  prevCharR = "";
                } else {
                  if (prevCharL.substring(prevCharL.length - 1, prevCharL.length) != " ") {
                    prevCharL = prevCharL + " ";
                  }
                  prevCharR = "";
                }
              }
            } else {
              if (z + 1 < splittedTextR.length) {
                prevCharR = prevCharR + ">";
              }
            }
          }
          if (prevCharR.length > 0) {
            prevCharL = prevCharL + prevCharR;
            prevCharR = "";
          }
        } else {
          prevCharL = prevCharL + splittedTextL[k];
        }
      } else {
        if (k > 0) {
          prevCharL = prevCharL + "<";
        }
      }
    }
    if (prevCharL.length > 0) {
      newSplittedText[newSplittedIdx] = prevCharL;
      newSplittedIdx++;
    }
  } else {
    newSplittedText[newSplittedIdx] = splittedTextL[0];
    newSplittedIdx++;
  }

  return newSplittedText;
}

//------------------------------------------
//Replace HMTL Tags with Symbol
//@param1 array containing tags and non-tags
//@param2 without symbol	
//@param3 with symbol	
//------------------------------------------
function replaceTagsWithSymbolX(tempTextArr, woSymbol, wSymbol) {
  var tempSearchFormat = "";
  var currSegment = "";

  var thisRegExpr = new RegExp('[^' + woSymbol + ']', 'g');

  for (var t = 0; t < tempTextArr.length; t++) {
    currSegment = tempTextArr[t];
    var idx1 = currSegment.indexOf("<");
    var idx2 = currSegment.indexOf(">");
    if (idx1 > -1 && idx2 > -1 && idx2 > idx1) {
      currSegment = currSegment.replace(thisRegExpr, wSymbol);
      tempSearchFormat = tempSearchFormat + currSegment;
    } else {
      tempSearchFormat = tempSearchFormat + currSegment;
    }
  }

  return tempSearchFormat;
}

//------------------------------------------
//Simple Split of a word
//@param1 delimiter
//@param2 word to split	
//------------------------------------------
function simpleSplitX(del, wordToSplit) {
  var resArr = Array();
  if (del == ' ') {  //global delimiter split (all) symbols
    wordToSplit = wordToSplit.replace(/[\, \. \( \) \" \; \: \? \!]/g, " ");
  }
  resArr = wordToSplit.split(del);
  return resArr;
}

//------------------------------------------
//disable all inputs from a form
//@param1 the object
//@param2 Ignore Once disable
//@param3 Ignore All disable
//@param4 Add To Dictionary disable
//@param5 Suggestions disable
//@param6 Change disable
//@param7 Change All disable
//@param8 Check Grammar disable
//@param9 Done disable
//------------------------------------------
function disableAllX(thisObj, p1, p2, p3, p4, p5, p6, p7, p8) {
  var thisForm = thisObj.vWinChr.document.forms[0];
  var formElemArr = thisForm.getElementsByTagName("input");
  for (var i = 0; i < formElemArr.length; i++) {
    if (p1 == 1 && formElemArr[i].id == "ignEdit_btn") {
      formElemArr[i].disabled = true;
    }
    if (p2 == 1 && formElemArr[i].id == "ignore_all") {
      formElemArr[i].disabled = true;
    }
    if (p3 == 1 && formElemArr[i].id == "add_to_dictionary") {
      formElemArr[i].disabled = true;
    }
    if (p5 == 1 && formElemArr[i].id == "change_edit_btn") {
      formElemArr[i].disabled = true;
    }
    if (p6 == 1 && formElemArr[i].id == "change_all_btn") {
      formElemArr[i].disabled = true;
    }
    if (p7 == 1 && formElemArr[i].id == "check_grammar") {
      formElemArr[i].disabled = true;
    }
    if (p8 == 1 && formElemArr[i].id == "done_btn") {
      formElemArr[i].disabled = true;
    }
  }
  //disable suggestions Pane
  if (p4 == 1) {
    var thisSuggPane = thisObj.vWinChr.document.getElementById("suggestionsPaneMain")
    thisSuggPane.style.backgroundColor = "#F8F8F8";
    var tbl = thisObj.vWinChr.document.getElementById('suggTable');
    for (var j = tbl.rows.length - 1; j > 0; j--) {
      if (tbl.rows[j].cells[0] != null) {
        tbl.rows[j].cells[0].onmouseover = "";
        tbl.rows[j].cells[0].className = "defCell"
        tbl.rows[j].cells[0].onmouseout = "";
        tbl.rows[j].cells[0].onclick = "";
        tbl.rows[j].cells[0].innerHTML = "\<font color\=gray\>" + tbl.rows[j].cells[0].innerHTML + "\<\/font\>"
      }
      if (tbl.rows[j].cells[1] != null) {
        tbl.rows[j].cells[1].onmouseover = "";
        tbl.rows[j].cells[1].className = "defCell"
        tbl.rows[j].cells[1].onmouseout = "";
        tbl.rows[j].cells[1].onclick = "";
        tbl.rows[j].cells[1].innerHTML = "\<font color\=gray\>" + tbl.rows[j].cells[0].innerHTML + "\<\/font\>"
      }
    }
    var elem = tbl.getElementsByTagName("td");
    elem[0].innerHTML = "\<font color\=gray\>\<b\>Suggestions:\<\/b\>" + "&nbsp;\(\<i\>Disabled\<\/i\>\)\<\/font\>"
  }
}

//------------------------------------------
//enable all inputs from a form
//@param1 the object
//------------------------------------------
function enableAllX(thisObj) {
  var thisForm = thisObj.vWinChr.document.forms[0];

  var formElemArr = thisForm.getElementsByTagName("input");

  for (var i = 0; i < formElemArr.length; i++) {
    formElemArr[i].disabled = false;

  }

  var thisSuggPane = thisObj.vWinChr.document.getElementById("suggestionsPaneMain")
  thisSuggPane.style.backgroundColor = "#FFFFFF";
  var tbl = thisObj.vWinChr.document.getElementById('suggTable');
  var elem = tbl.getElementsByTagName("td");
  elem[0].innerHTML = "\<b\>Suggestions:\<\/b\>";
}

//------------------------------------------
//is in array method
//@param1 the array to be tested
//------------------------------------------
function isInArrayX(arr, a) {
  for (i = 0; i < arr.length; i++) {
    if (arr[i] == a) {
      return true;
    }
  }
  return false;
}

//------------------------------------------
//is a tag method
//@param1 the text to be tested
//------------------------------------------
function isTagX(thisText) {
  var isTag = false;
  var idx1 = thisText.indexOf("<");
  var idx2 = thisText.indexOf(">");
  if (idx1 > -1 && idx2 > -1) {
    if (idx2 > idx1) {
      isTag = true;
    }
  }
  return isTag;
}

//------------------------------------------
//has an error method
//@param1 the text to be tested
//------------------------------------------
function hasErrorX(thisText) {
  var hasError = false;
  var idx1 = thisText.indexOf("\[\*\]");

  var idx2 = thisText.indexOf("\[\/\*\]");

  if (idx1 == -1 && idx2 == -1) {
    idx1 = thisText.indexOf("\[\~\]");
    idx2 = thisText.indexOf("\[\/\~\]");
  }
  if (idx1 > -1 && idx2 > -1) {
    if (idx2 > idx1) {
      hasError = true;
    }
  }
  return hasError;
}

//------------------------------------------
//get an error (first come first served)
//@param1 the text to be tested
//@return Array(error word, Uppercase word)
//------------------------------------------
function getErrorX(thisText) {
  var errorWrd = "";
  var upperCase = "N";
  var idx1 = thisText.indexOf("\[\*\]");
  var idx2 = thisText.indexOf("\[\/\*\]");
  var idx3 = thisText.indexOf("\[\~\]");

  var idx4 = thisText.indexOf("\[\/\~\]");

  if (idx1 > -1 && idx3 > -1) {
    if (idx1 < idx3) {
      if (idx1 > -1 && idx2 > -1) {
        if (idx2 > idx1) {
          errorWrd = thisText.substring(idx1 + 3, idx2);
        }
      }
    } else {
      if (idx3 > -1 && idx4 > -1) {
        if (idx4 > idx3) {
          errorWrd = thisText.substring(idx3 + 3, idx4);
          upperCase = "Y";
        }
      }
    }
  } else if (idx1 > -1) {
    if (idx1 > -1 && idx2 > -1) {
      if (idx2 > idx1) {
        errorWrd = thisText.substring(idx1 + 3, idx2);
      }
    }
  } else if (idx3 > -1) {
    if (idx3 > -1 && idx4 > -1) {
      if (idx4 > idx3) {
        errorWrd = thisText.substring(idx3 + 3, idx4);
        upperCase = "Y";
      }
    }
  }
  return Array(errorWrd, upperCase);
}

//------------------------------------------
//replace error tags
//@param1 the text to be replaced
//@return text without Error Tags
//------------------------------------------
function replaceErrorTagsX(thisText) {
  thisText = thisText.replace(/\[\*\]/g, "");
  thisText = thisText.replace(/\[\/\*\]/g, "");
  thisText = thisText.replace(/\[\~\]/g, "");
  thisText = thisText.replace(/\[\/\~\]/g, "");
  return thisText;
}

//#window processing methods area

//------------------------------------------
//populate suggestions 
//@param1 the spell checker object
//@param2 the array of suggestions
//------------------------------------------
function populateSuggestionsX(thisObj, suggArr) {
  if (thisObj.vWinChr == null || thisObj.vWinChr.closed == true) {
    return;
  }
  var tbl = thisObj.vWinChr.document.getElementById('suggTable');
  var lastRow = 0;
  var row = "";
  for (var j = tbl.rows.length - 1; j > 0; j--) {
    tbl.deleteRow(j);
  }
  for (var i = 0; i < suggArr.length; i++) {
    lastRow = tbl.rows.length;
    row = tbl.insertRow(lastRow);
    var cellLeft = row.insertCell(0);
    cellLeft.innerHTML = suggArr[i];
    cellLeft.setAttribute("width", "50%");
    cellLeft.setAttribute("id", i + "-" + 0);
    cellLeft.style.cursor = "pointer"
    cellLeft.className = "defCell"
    cellLeft.onmouseover = function () {
      highLightCell(thisObj, this, true);
    };
    cellLeft.onmouseout = function () {
      highLightCell(thisObj, this, false);
    };
    cellLeft.onclick = function () {
      selectDeselectCell(thisObj, this);
    }
    if (suggArr.length > 4) {
      i++;
      if (i < suggArr.length) {
        var cellRight = row.insertCell(1);
        cellRight.innerHTML = suggArr[i];
        cellRight.setAttribute("width", "50%");
        cellRight.setAttribute("id", i + "-" + 1);
        cellRight.style.cursor = "pointer";
        cellRight.className = "defCell";
        cellRight.onmouseover = function () {
          highLightCell(thisObj, this, true);
        };
        cellRight.onmouseout = function () {
          highLightCell(thisObj, this, false);
        };
        cellRight.onclick = function () {
          selectDeselectCell(thisObj, this);
        }
      }
    } else {
      var cellRight = row.insertCell(1);
      cellRight.innerHTML = "&nbsp;";
      cellRight.setAttribute("width", "50%");
      cellRight.className = "defCell";
    }
  }
}

function deselectAll(thisObjWin, thisId) {
  var tbl = thisObjWin.vWinChr.document.getElementById('suggTable');
  var elemArr = tbl.getElementsByTagName("td");
  for (var i = 0; i < elemArr.length; i++) {
    if (elemArr[i].id != "titleCell" && elemArr[i].id != thisId) {
      elemArr[i].className = "defCell";
    }
  }
}

function selectDeselectCell(thisObjWin, thisObj) {
  var thisCell = thisObjWin.vWinChr.document.getElementById(thisObj.id);
  if (thisCell.className != "selCell") {
    deselectAll(thisObjWin, thisObj.id);
    thisCell.className = "selCell";
  } else {
    thisCell.className = "defCell";
  }
}

function highLightCell(thisObjWin, thisObj, doHover) {
  var thisCell = thisObjWin.vWinChr.document.getElementById(thisObj.id);
  if (doHover == true && thisCell.className != "selCell") {
    thisCell.className = "suggCell";
  } else if (thisCell.className != "selCell") {
    thisCell.className = "defCell";
  }
}

//#end of window processing methods area

new PureSpellChecker();

//------------------------------------------
//Simple Vector Replacement of a word
//@param1 raw text data from user's input
//@param2 the misspelled word	
//@param3 approximate location of word
//------------------------------------------
PureSpellChecker.prototype.simpleReplace = function () {
  var docText = arguments[0];
  var errorWord = arguments[1];
  var approxLocation = arguments[2];
  var tempDocText = "";
  var textBeg = "";
  var textEnd = "";
  var tempTextArr = PureSpellChecker.splitHTMLTags(docText, true);
  var tempSearchFormat = PureSpellChecker.replaceTagsWithSymbol(tempTextArr, "#", "#");
  tempDocText = tempSearchFormat.toLowerCase();
  var strStartPos = tempDocText.indexOf(errorWord, approxLocation);

  errorWord = tempSearchFormat.substring(strStartPos, strStartPos + errorWord.length);

  if (strStartPos != -1) {
    textBeg = docText.substring(0, strStartPos);
    textEnd = docText.substring(strStartPos + errorWord.length);
  }
  return (textBeg + "[*]" + errorWord + "[\/*]" + textEnd);
}

//------------------------------------------
//Complex Vector Replacement of a word
//@param1 raw text data from user's input
//@param2 the misspelled word	
//@param3 approximate location of word
//------------------------------------------
PureSpellChecker.prototype.vectorReplace = function () {
  var docText = arguments[0];
  var errorWord = arguments[1];
  var approxLocation = arguments[2];
  var tempDocText = "";
  var tempWord = "";
  var textBeg = "";
  var textEnd = "";
  var buildWord = "";
  var thisRegExp = "";
  var currPointer = 0;
  var wordLength = 0;
  var delStart = 0;
  var tempTextArr = PureSpellChecker.splitHTMLTags(docText, true);
  var tempSearchFormat = PureSpellChecker.replaceTagsWithSymbol(tempTextArr, "#", "#"); ;
  tempDocText = tempSearchFormat.substring(approxLocation);
  tempDocText = tempDocText.toLowerCase().replace(this.pattA, '#');

  tempWord = errorWord.toLowerCase().replace(this.pattA, '');

  for (var i = 0; i < tempWord.length; i++) {
    if (i + 1 == tempWord.length) {
      thisRegExp = thisRegExp + "[" + tempWord.charAt(i) + "]";
    }
    else {
      thisRegExp = thisRegExp + "[" + tempWord.charAt(i) + "]" + this.pattF;
    }
  }

  var patt1 = new RegExp(thisRegExp);
  var patt2 = new RegExp(this.pattB);
  currPointer = patt1.exec(tempDocText).index;
  delStart = currPointer;

  strStartPos = approxLocation + currPointer;

  while (buildWord != tempWord) {
    if (patt2.test(tempDocText.charAt(currPointer))) {
      buildWord = buildWord + tempDocText.charAt(currPointer);
    }
    currPointer = currPointer + 1;

  }

  errorWord = docText.substring(strStartPos, strStartPos + currPointer - delStart);

  if (strStartPos != -1) {
    textBeg = docText.substring(0, strStartPos);
    textEnd = docText.substring(strStartPos + currPointer - delStart);
  }
  return (textBeg + "[*]" + errorWord + "[\/*]" + textEnd);
}

//------------------------------------------
//get an Approximation of Characters scanned of a word
//@param1 original text
//@param2 last word scanned	
//@param3 prev chars scanned
//------------------------------------------
PureSpellChecker.prototype.getCharsScanned = function () {
  var orgText = arguments[0];
  var lastWordScanned = arguments[1];
  var prevCharsScanned = arguments[2];
  var tempTextArr = PureSpellChecker.splitHTMLTags(orgText, true);
  var tempSearchFormat = PureSpellChecker.replaceTagsWithSymbol(tempTextArr, "#", "%");
  orgText = tempSearchFormat;
  orgText = orgText.toLowerCase().substring(prevCharsScanned);
  lastWordScanned = lastWordScanned.toLowerCase();
  var currPointer = 0;

  currPointer = orgText.indexOf(lastWordScanned);

  if (currPointer > -1) {
    currPointer = currPointer + lastWordScanned.length
  } else {
    var tempText = orgText.replace(this.pattA, '#');
    var tempWord = lastWordScanned.replace(this.pattA, '');
    var thisRegExp = "";
    for (var i = 0; i < tempWord.length; i++) {
      if (i + 1 == tempWord.length) {
        thisRegExp = thisRegExp + "[" + tempWord.charAt(i) + "]";
      }
      else {
        thisRegExp = thisRegExp + "[" + tempWord.charAt(i) + "]" + this.pattF;
      }
    }
    var patt1 = new RegExp(thisRegExp);
    var patt2 = new RegExp(this.pattB)
    currPointer = patt1.exec(tempText).index;
    var buildWord = "";
    while (buildWord != tempWord) {
      if (patt2.test(tempText.charAt(currPointer))) {
        buildWord = buildWord + tempText.charAt(currPointer);
      }
      currPointer = currPointer + 1
    }
  }
  return prevCharsScanned + currPointer;
}

//------------------------------------------
//Initialize Cylidner Method
//@param1 the reference to the cylinder's cluster location	
//------------------------------------------
PureSpellChecker.prototype.initializeCylinders = function () {
  var loadCylinders = false;
  if (this.cylinder.src == "" || this.cylinder.src == "about:blank" || this.cylinder.src == null || this.cylinder.src.indexOf("_cylinder.htm") == -1) {
    loadCylinders = true;
  }
  switch (this.preferredLanguage) {
    case 'english':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "english_cylinder.htm"; }
      this.lan = 'en';
      this.dicLength = 1652018;
      break;
    case 'spanish':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "spanish_cylinder.htm"; }
      this.lan = 'es';
      this.dicLength = 2667546;
      break;
    case 'french':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "french_cylinder.htm"; }
      this.lan = 'fr';
      this.dicLength = 1440373;
      break;
    case 'deutsch':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "deutsch_cylinder.htm"; }
      this.lan = 'de';
      this.dicLength = 6735905;
      break;
    case 'italian':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "italian_cylinder.htm"; }
      this.lan = 'it';
      this.dicLength = 3010943;
      break;
    case 'portuguese':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "portuguese_cylinder.htm"; }
      this.lan = 'po';
      this.dicLength = 4344698;
      break;
    case 'greek':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "greek_cylinder.htm"; }
      this.lan = 'gr';
      break;
    case 'dutch':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "dutch_cylinder.htm"; }
      this.lan = 'du';
      this.dicLength = 2636305;
      break;
    case 'croatian':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "croatian_cylinder.htm"; }
      this.lan = 'cr';
      break;
    case 'danish':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "danish_cylinder.htm"; }
      this.lan = 'da';
      break;
    case 'russian':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "russian_cylinder.htm"; }
      this.lan = 'ru';
      break;
    case 'bulgarian':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "bulgarian_cylinder.htm"; }
      this.lan = 'bu';
      break;
    case 'polish':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "polish_cylinder.htm"; }
      this.lan = 'po';
      break;
    case 'romanian':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "romanian_cylinder.htm"; }
      this.lan = 'ro';
      break;
    case 'swedish':
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "swedish_cylinder.htm"; }
      this.lan = 'sw';
      break;
    default:
      if (loadCylinders == true) { this.cylinder.src = this.dicWordsPath + "english_cylinder.htm"; }
      this.lan = 'en';
  }
  if (this.preloadDic == true) {
    this.preloadDic = false; //used when user decides to preload the dictionary
    return false;
  }
  var myObj = this;
  if (this.processStarted == false || this.cylinder.contentWindow.document.body == null) {
    this.updateProgressBar(10, true, 1);
    this.processStarted = true;
    setTimeout((function () { myObj.display(false); }), 100); //iframe has not been loaded yet
    return false;
  }
  if (this.cylinder.contentWindow.document.body.innerHTML.indexOf("\|\-\*\-\|") == -1) {
    var thisCnt = Math.floor((this.cylinder.contentWindow.document.body.innerHTML.length * 10) / this.dicLength);
    this.updateProgressBar(thisCnt, false, 1);
    setTimeout((function () { myObj.display(false); }), 100); //iframe has not been loaded yet
    return false;
  }
  this.updateProgressBar(10, false, 1);
  this.cylinder = document.getElementById("cylinder");
  var cylinderRef = this.cylinder.contentWindow;
  var cylinderCnt = cylinderRef.document.getElementsByTagName('input');
  for (var i = 0; i < cylinderCnt.length; i++) {
    this.SrcCylinder = this.SrcCylinder + cylinderRef.document.getElementById("cylinder" + i).innerHTML;
  }
  return true;
}

//------------------------------------------
//preLoad the word dictionary when the page is loading
//------------------------------------------
PureSpellChecker.prototype.preloadDictionary = function () {
  this.preloadDic = true;
  this.initializeCylinders();
}

//------------------------------------------
//Search Cylinder | Search Level 1
//@param1 word to be searched	
//@param2 language to be used
//------------------------------------------
PureSpellChecker.prototype.searchCylinder = function () {
  var thisWord = arguments[0];
  var lan = arguments[1];
  var wordFound = false;
  var theTextArr = Array();
  var charSplit = "";
  var charSplitPrev = "";
  var doSplit = false;
  var matches = "";
  var wordsFound = 0;
  var punctuationChars = "\.\,\(\)\"\;\:\?\!";
  var caseArr = Array();
  var caseArrIdx = 0;

  var x, i;

  for (i = 0; i < thisWord.length; i++) {
    if (punctuationChars.indexOf(thisWord.charAt(i)) != -1) {
      caseArr[caseArrIdx] = thisWord.charAt(i);
      caseArrIdx = caseArrIdx + 1;
    }
  }

  if (caseArrIdx > 1) {
    charSplit = " ";
    thisWord = thisWord.replace(/[\, \. \( \) \" \; \: \? \!]/g, " ");
    theTextArr = thisWord.split(" ");
    for (x = 0; x < theTextArr.length; x++) {
      if (theTextArr[x] == "" || !isNaN(theTextArr[x])) {
        matches = matches + "1" + "|";
      } else {
        wordFound = this.searchCylinderCluster(theTextArr[x], lan);
        if (wordFound == true) {
          if (this.checkGrammar == true && charSplitPrev == ".") {
            matches = matches + "0" + "|";
          } else {
            matches = matches + "1" + "|";
          }
        } else {
          matches = matches + "0" + "|";
        }
        wordsFound = wordsFound + 1;
      }
      charSplitPrev = caseArr[x];
    }
  } else if (caseArrIdx == 1) {
    charSplit = caseArr[0];
    theTextArr = thisWord.split(charSplit);
    for (x = 0; x < theTextArr.length; x++) {
      if (theTextArr[x] == "" || !isNaN(theTextArr[x])) {
        matches = matches + "1" + "|";
      } else {
        wordFound = this.searchCylinderCluster(theTextArr[x], lan);
        if (wordFound == true) {
          if (this.checkGrammar == true && charSplitPrev == ".") {
            matches = matches + "0" + "|";
          } else {
            matches = matches + "1" + "|";
          }
        } else {
          matches = matches + "0" + "|";
        }
        wordsFound = wordsFound + 1;
      }
      charSplitPrev = charSplit;
    }
  } else {
    charSplit = "";
    wordFound = this.searchCylinderCluster(thisWord, lan);
    if (wordFound == true) {
      matches = matches + "1" + "|";
    } else {
      matches = matches + "0" + "|";
    }
    wordsFound = wordsFound + 1;
  }



  matches = matches.substring(0, matches.length - 1);

  if (matches.indexOf("1") == -1) {
    doSplit = false;
  } else {
    if (matches.indexOf("|") != -1) {
      doSplit = true;
    }
  }
  return Array(doSplit, charSplit, matches, wordsFound);
}

//------------------------------------------
//Search Cylinder Cluster | Search Level 2
//@param1 word to be searched	
//@param2 language to be used
//------------------------------------------
PureSpellChecker.prototype.searchCylinderCluster = function () {
  var thisWord = arguments[0];
  var lan = arguments[1];
  var wordFound = false;
  var theTextArr = Array();

  var compositeSearch = false;

  if (thisWord.indexOf("'") != -1 && thisWord.indexOf("-") != -1) {
    //word can not have both symbols
  } else if (thisWord.indexOf("'") != -1) { //execute composite search
    compositeSearch = true;
    theTextArr = thisWord.split("'");
    for (var x = 0; x < theTextArr.length; x++) {
      if (theTextArr.length > 2) {
        wordFound = false;
        x = theTextArr.length;
      } else if (theTextArr[x] == "" && (x == 0)) {
        wordFound = false;
        x = theTextArr.length;
      } else if (theTextArr[x] == "" && (x == (theTextArr.length - 1)) && lan == "en") {
        if (theTextArr[(x - 1)].charAt((theTextArr[(x - 1)].length - 1)) == "s") {
          wordFound = true;
        } else {
          wordFound = false;
          x = theTextArr.length;
        }
      } else if (theTextArr[x] == "m" && (x == (theTextArr.length - 1)) && lan == "en") {
        if (theTextArr[(x - 1)].charAt((theTextArr[(x - 1)].length - 1)) == "i") {
          wordFound = true;
        } else {
          wordFound = false;
          x = theTextArr.length;
        }
      } else {
        if (this.SrcCylinder.indexOf(("'" + theTextArr[x] + "'")) != -1) {
          wordFound = true;
        } else {
          wordFound = false;
          x = theTextArr.length;
        }
      }
    }
  } else if (thisWord.indexOf("-") != -1) {
    compositeSearch = true;
    theTextArr = thisWord.split("-");
    for (var y = 0; y < theTextArr.length; y++) {
      if (theTextArr.length > 3) {
        wordFound = false;
        y = theTextArr.length;
      } else if (theTextArr[y] == "" && theTextArr.length == 2) {
        wordFound = false;
        y = theTextArr.length;
      }
      else {
        if (this.SrcCylinder.indexOf(("'" + theTextArr[y] + "'")) != -1) {
          wordFound = true;
        } else {
          wordFound = false;
          y = theTextArr.length;
        }
      }
    }
  } else { //execute single search  
    if (this.SrcCylinder.indexOf(("'" + thisWord + "'")) != -1) {
      wordFound = true;
    }
  }
  return wordFound;
}

//------------------------------------------
//Get All Errors Method
//@param1 the string	
//------------------------------------------
PureSpellChecker.prototype.getAllErrors = function () {
  var thisStr = arguments[0];
  var splitIdx = 0;
  var errArr = Array();
  var retArr = Array();
  var retArrIdx = 0;

  var numErrors = thisStr.replace(/\[\~\]/g, "\[\*\]").split("\[\*\]").length;

  if (numErrors == 1) {
    retArr[retArrIdx] = thisStr;
    return retArr;
  }

  for (var u = 1; u < numErrors; u++) {
    errArr = PureSpellChecker.getError(thisStr);
    if (errArr[0] != "") {
      splitIdx = thisStr.indexOf(errArr[0]) + errArr[0].length + 4;
      if (splitIdx < thisStr.length) {
        retArr[retArrIdx] = thisStr.substring(0, splitIdx);
        retArrIdx = retArrIdx + 1;
        thisStr = thisStr.substring(splitIdx);
      } else {
        retArr[retArrIdx] = thisStr;
        thisStr = "";
      }
    }
  }
  if (thisStr.length > 0) {
    retArr[retArrIdx - 1] = retArr[retArrIdx - 1] + thisStr;
  }
  return retArr;
}

//------------------------------------------
//Display Spell Checker method
//@param1 text to be output into the checkerPane	
//------------------------------------------
PureSpellChecker.prototype.outputHtmlSpellChecker = function () {
  var outText = arguments[0];
  var tempTextArr = PureSpellChecker.splitHTMLTags(outText, true);
  var tempTextIdx = 0;
  var phraseArr = Array();
  var thisStr = "";
  var strCount = 1;
  var errArr = Array();

  var errCnt = 0;

  for (var q = 0; q < tempTextArr.length; q++) {
    if (PureSpellChecker.isTag(tempTextArr[q])) {
      this.mySplitTxt[tempTextIdx] = tempTextArr[q];
      tempTextIdx = tempTextIdx + 1;
    } else {
      tempTextArr[q] = tempTextArr[q].replace(/\[\/\*\]\[\*\]/g, '\[\/\*\] \[\*\]')
      tempTextArr[q] = tempTextArr[q].replace(/\[\/\*\]\[\~\]/g, '\[\/\*\] \[\~\]')
      tempTextArr[q] = tempTextArr[q].replace(/\[\/\~\]\[\*\]/g, '\[\/\~\] \[\*\]')
      tempTextArr[q] = tempTextArr[q].replace(/\[\/\~\]\[\~\]/g, '\[\/\~\] \[\~\]')
      phraseArr = tempTextArr[q].split(" ");
      thisStr = "";
      strCount = 1;
      if (phraseArr.length == 1) {
        errArr = this.getAllErrors(phraseArr[0]);
        for (errCnt = 0; errCnt < errArr.length; errCnt++) {
          this.mySplitTxt[tempTextIdx] = errArr[errCnt];
          tempTextIdx = tempTextIdx + 1;
        }
      } else {
        for (var i = 0; i < phraseArr.length; i++) {
          if (i == 0 && phraseArr[i] != "" || i > 0) {
            if (!(PureSpellChecker.hasError(phraseArr[i]))) {
              thisStr = (phraseArr.length == i + 1) ? thisStr + phraseArr[i] : thisStr + phraseArr[i] + " ";
              strCount = strCount + 1;
            } else {
              if (!PureSpellChecker.hasError(thisStr)) {
                thisStr = (phraseArr.length == i + 1) ? thisStr + phraseArr[i] : thisStr + phraseArr[i] + " ";
              } else {
                errArr = this.getAllErrors(thisStr);
                for (errCnt = 0; errCnt < errArr.length; errCnt++) {
                  this.mySplitTxt[tempTextIdx] = errArr[errCnt];
                  tempTextIdx = tempTextIdx + 1;
                }
                thisStr = (phraseArr.length == i + 1) ? phraseArr[i] : phraseArr[i] + " ";
              }
              strCount = 1;
            }
            if (strCount > 6) {
              errArr = this.getAllErrors(thisStr);
              for (errCnt = 0; errCnt < errArr.length; errCnt++) {
                this.mySplitTxt[tempTextIdx] = errArr[errCnt];
                tempTextIdx = tempTextIdx + 1;
              }
              thisStr = "";
              strCount = 1;
            }
          } else {
            thisStr = (phraseArr.length == i + 1) ? "" : " ";
          }
        }
        if (thisStr != "") {
          errArr = this.getAllErrors(thisStr);
          for (errCnt = 0; errCnt < errArr.length; errCnt++) {
            this.mySplitTxt[tempTextIdx] = errArr[errCnt];
            tempTextIdx = tempTextIdx + 1;
          }
        }
      }
    }
  }

  for (var w = 0; w < this.mySplitTxt.length; w++) {
    if (!(PureSpellChecker.isTag(this.mySplitTxt[w])) && PureSpellChecker.hasError(this.mySplitTxt[w])) {
      this.currIdx = w;
      break;
    }
  }

  outText = this.mySplitTxt[this.currIdx].replace(/\[\*\]/g, "<font color=red>");
  outText = outText.replace(/\[\/\*\]/g, "<\/font>");
  outText = outText.replace(/\[\~\]/g, "<font color=red>").replace(/\[\/\~\]/g, "<\/font>");

  var thisSpChObj = this;

  if (this.vWinChr != null && this.vWinChr.closed == true) {
    return;
  }

  this.vWinChr.document.open();
  this.vWinChr.document.write("<html>");
  this.vWinChr.document.write("<head><title>Spell Checker<\/title><\/head>");
  this.vWinChr.document.write("<body>");
  this.vWinChr.document.write("<style type=\"text/css\">");
  this.vWinChr.document.write(".suggCell{");
  this.vWinChr.document.write("border-top: 1px solid #667;");
  this.vWinChr.document.write("border-bottom: 1px solid #667;");
  this.vWinChr.document.write("border-right: 1px solid #667;");
  this.vWinChr.document.write("border-left: 1px solid #667;");
  this.vWinChr.document.write("}");
  this.vWinChr.document.write(".selCell{");
  this.vWinChr.document.write("border-top: 1px solid #FF0000;");
  this.vWinChr.document.write("border-bottom: 1px solid #FF0000;");
  this.vWinChr.document.write("border-right: 1px solid #FF0000;");
  this.vWinChr.document.write("border-left: 1px solid #FF0000;");
  this.vWinChr.document.write("}");
  this.vWinChr.document.write(".defCell{");
  this.vWinChr.document.write("border-top: 1px solid #FFFFFF;");
  this.vWinChr.document.write("border-bottom: 1px solid #FFFFFF;");
  this.vWinChr.document.write("border-right: 1px solid #FFFFFF;");
  this.vWinChr.document.write("border-left: 1px solid #FFFFFF;");
  this.vWinChr.document.write("}");
  this.vWinChr.document.write(".btnSptor{");
  this.vWinChr.document.write("padding: 0px 3px 10px 3px;");
  this.vWinChr.document.write("}");
  this.vWinChr.document.write("<\/style>");
  this.vWinChr.document.write("<form>");
  this.vWinChr.document.write("<table id=\"master_container\" border=\"0\">");
  this.vWinChr.document.write("<tr><td>");
  this.vWinChr.document.write("<div name=\"checkerContentFrame\" ");
  this.vWinChr.document.write(" id=\"checkerContentFrame\">");
  this.vWinChr.document.write("<div name=\"checkerPane\" ");
  this.vWinChr.document.write("id=\"checkerPane\" ");
  this.vWinChr.document.write("onClick=\"\" ");
  this.vWinChr.document.write("style=\"");
  this.vWinChr.document.write("border: 1px solid #667;");
  this.vWinChr.document.write("width:300px;");
  this.vWinChr.document.write("height:100px;");
  this.vWinChr.document.write("overflow:scroll;");
  this.vWinChr.document.write("overflow-x:hidden;");
  this.vWinChr.document.write("overflow-y:scroll;");
  this.vWinChr.document.write("\" ");
  this.vWinChr.document.write(">");
  this.vWinChr.document.write(outText);
  this.vWinChr.document.write("<\/div>");
  this.vWinChr.document.write("<\/div>");
  this.vWinChr.document.write("<\/td><td valign=\"top\" >");
  this.vWinChr.document.write("<div class=\"btnSptor\"><input type=\"button\" ");
  this.vWinChr.document.write("value=\"Ignore Once\" ");
  this.vWinChr.document.write("id=\"ignEdit_btn\" ");
  this.vWinChr.document.write("onClick=\"\" ");
  this.vWinChr.document.write("style=\"width:130px\" \/>");
  this.vWinChr.document.write("<\/div><div class=\"btnSptor\">");
  this.vWinChr.document.write("<input type=\"button\" ");
  this.vWinChr.document.write("value=\"Ignore All\" ");
  this.vWinChr.document.write("id=\"ignore_all\" ");
  this.vWinChr.document.write("onClick=\"\" ");
  this.vWinChr.document.write("style=\"width:130px\" \/><\/div>");
  this.vWinChr.document.write("<div class=\"btnSptor\">");
  this.vWinChr.document.write("<input type=\"button\" ");
  this.vWinChr.document.write("value=\"Add to Dictionary\" ");
  this.vWinChr.document.write("id=\"add_to_dictionary\" ");
  this.vWinChr.document.write("onClick=\"\" ");
  this.vWinChr.document.write("style=\"width:130px\" \/><\/div>");
  this.vWinChr.document.write("<\/td><td rowspan=\"2\" valign=\"bottom\">");
  this.vWinChr.document.write("<div class=\"btnSptor\">");
  this.vWinChr.document.write("<input type=\"button\" ");
  this.vWinChr.document.write("value=\"Done\" ");
  this.vWinChr.document.write("id=\"done_btn\" ");
  this.vWinChr.document.write("onClick=\"\" ");
  this.vWinChr.document.write("style=\"width:75px\" \/>");
  this.vWinChr.document.write("<\/div>");
  this.vWinChr.document.write("<\/td><\/tr>");
  this.vWinChr.document.write("<tr><td>");
  this.vWinChr.document.write("<div name=\"suggestionsContentFrame\" ");
  this.vWinChr.document.write(" id=\"suggestionsContentFrame\">");
  this.vWinChr.document.write("<div name=\"suggestionsPane\" ");
  this.vWinChr.document.write("id=\"suggestionsPaneMain\" ");
  this.vWinChr.document.write("onClick=\"\" ");
  this.vWinChr.document.write("style=\"");
  this.vWinChr.document.write("border: 1px solid #667;");
  this.vWinChr.document.write("width:300px;");
  this.vWinChr.document.write("height:100px;");
  this.vWinChr.document.write("overflow:scroll;");
  this.vWinChr.document.write("overflow-x:hidden;");
  this.vWinChr.document.write("overflow-y:scroll;");
  this.vWinChr.document.write("\" >");
  this.vWinChr.document.write("<table width=\"100%\" border=\"1\" style=\"");
  this.vWinChr.document.write("border: 1px solid #FFFFFF;\" id=\"suggTable\">");
  this.vWinChr.document.write("<tr><td colspan=\"2\" id=\"titleCell\"");
  this.vWinChr.document.write(" class=\"defCell\">");
  this.vWinChr.document.write("<b>Suggestions:<\/b>");
  this.vWinChr.document.write("<\/td><\/tr>");
  this.vWinChr.document.write("<\/table>");
  this.vWinChr.document.write("<\/div>");
  this.vWinChr.document.write("<\/div>");
  this.vWinChr.document.write("<\/td><td valign=\"top\" >");
  this.vWinChr.document.write("<div class=\"btnSptor\">");
  this.vWinChr.document.write("<input type=\"button\" ");
  this.vWinChr.document.write("value=\"Change\" ");
  this.vWinChr.document.write("id=\"change_edit_btn\" ");
  this.vWinChr.document.write("onClick=\"\" style=\"width:130px\"");
  this.vWinChr.document.write("\/><\/div><div class=\"btnSptor\">");
  this.vWinChr.document.write("<input type=\"button\" ");
  this.vWinChr.document.write("value=\"Change All\" ");
  this.vWinChr.document.write("id=\"change_all_btn\" ");
  this.vWinChr.document.write("onClick=\"\" ");
  this.vWinChr.document.write("style=\"width:130px\" \/><\/div>");
  this.vWinChr.document.write("<div class=\"btnSptor\">");
  this.vWinChr.document.write("<input type=\"checkbox\" value=\"1\" id=\"check_grammar\"");
  if (this.checkGrammar == true) { this.vWinChr.document.write("checked"); }
  this.vWinChr.document.write(">&nbsp;<small>Check Grammar<\/small>");
  this.vWinChr.document.write("<\/div>");
  this.vWinChr.document.write("<\/td><\/tr>");
  this.vWinChr.document.write("<\/table>");
  this.vWinChr.document.write("<br><br><\/form>");
  this.vWinChr.document.write("<\/body>");
  this.vWinChr.document.write("<\/html>");
  this.vWinChr.document.close();
  //find suggestion for first error
  var errRes = PureSpellChecker.getError(this.mySplitTxt[this.currIdx]);
  var thisSuggestions = this.findSuggestions(errRes[0], errRes[1]);

  PureSpellChecker.populateSuggestions(thisSpChObj, thisSuggestions);

  //New window overloaded methods
  this.vWinChr.document.getElementById("checkerPane").onclick = function () {
    PureSpellChecker.disableAll(thisSpChObj, 0, 1, 1, 1, 0, 1, 1, 1);
    thisSpChObj.vWinChr.focus();
    var chrFrame = thisSpChObj.vWinChr.document.getElementById("checkerContentFrame");
    var chrPane = thisSpChObj.vWinChr.document.getElementById("checkerPane");
    var editableContent = chrFrame.getElementsByTagName("textarea");
    if (editableContent.length == 0) {
      thisSpChObj.vWinChr.document.getElementById("ignEdit_btn").value = "Undo Edit";
      var theText = chrPane.innerHTML;
      theText = theText.replace(/\<font color\=red\>/gi, "");
      theText = theText.replace(/\<font color\=\"red\"\>/gi, "");
      theText = theText.replace(/\<\/font\>/gi, "");
      chrFrame.innerHTML = "<textarea name=\"editableArea\"" + " rows=\"6\" cols=\"40\" wrap=\"hard\"" + " style=\"width:300px;\">" + theText + "<\/textarea>";
    }
  };
  this.vWinChr.document.getElementById("change_edit_btn").onclick = function () {
    PureSpellChecker.disableAll(thisSpChObj, 1, 1, 1, 0, 1, 1, 1, 1);
    thisSpChObj.vWinChr.focus();
    var chrFrame = "";
    var chrPane = "";
    var outText = "";
    var errRes = Array();
    var thisSuggestions = "";
    var startIdx = 0;
    var endIdx = 0;
    var startIdx2 = 0;
    var endIdx2 = 0;
    var textSuff = "";
    var textPref = "";
    var errType = 1;

    var hasMoreErrors = false;

    if (thisSpChObj.vWinChr.document.getElementById("ignEdit_btn").value == "Undo Edit") {
      chrFrame = thisSpChObj.vWinChr.document.getElementById("checkerContentFrame");
      chrPane = thisSpChObj.vWinChr.document.getElementById("checkerPane");
      var editableContent = chrFrame.getElementsByTagName("textarea");
      var editedText = editableContent[0].value;
      errType = 1;
      var startDelta = thisSpChObj.mySplitTxt[thisSpChObj.currIdx].indexOf("\[\*\]");
      var endDelta = thisSpChObj.mySplitTxt[thisSpChObj.currIdx].indexOf("\[\/\*\]");
      if (startDelta == -1 && endDelta == -1) {
        startDelta = thisSpChObj.mySplitTxt[thisSpChObj.currIdx].indexOf("\[\~\]");
        endDelta = thisSpChObj.mySplitTxt[thisSpChObj.currIdx].indexOf("\[\/\~\]");
        errType = 2;
      }
      endDelta = thisSpChObj.mySplitTxt[thisSpChObj.currIdx].length - endDelta;
      if (errType == 1) {
        startIdx = thisSpChObj.docText.indexOf("\[\*\]") - startDelta;
        endIdx = thisSpChObj.docText.indexOf("\[\/\*\]") + endDelta;
      } else {
        startIdx = thisSpChObj.docText.indexOf("\[\~\]") - startDelta;
        endIdx = thisSpChObj.docText.indexOf("\[\/\~\]") + endDelta;
      }
      textSuff = thisSpChObj.docText.substring(0, startIdx);
      textPref = thisSpChObj.docText.substring(endIdx);
      thisSpChObj.docText = textSuff + editedText + textPref;
      thisSpChObj.mySplitTxt[thisSpChObj.currIdx] = editedText;
      thisSpChObj.wordsCorrected = thisSpChObj.wordsCorrected + 1;
      chrFrame.innerHTML = "<div name=\"checkerPane\" " + "id=\"checkerPane\" " + "onClick=\"\" " + "style=\"" + "border: 1px solid #667;" + "width:300px;" + "height:100px;" + "overflow:scroll;" + "overflow-x:hidden;" + "overflow-y:scroll;" + "\" >" + "<\/div>";
      thisSpChObj.vWinChr.document.getElementById("ignEdit_btn").value = "Ignore Once";
      thisSpChObj.vWinChr.document.getElementById("checkerPane").onclick = function () {
        PureSpellChecker.disableAll(thisSpChObj, 0, 1, 1, 1, 0, 1, 1, 1);
        thisSpChObj.vWinChr.focus();
        var chrFrame = thisSpChObj.vWinChr.document.getElementById("checkerContentFrame");
        var chrPane = thisSpChObj.vWinChr.document.getElementById("checkerPane");
        var editableContent = chrFrame.getElementsByTagName("textarea");
        if (editableContent.length == 0) {
          thisSpChObj.vWinChr.document.getElementById("ignEdit_btn").value = "Undo Edit";
          var theText = chrPane.innerHTML;
          theText = theText.replace(/\<font color\=red\>/gi, "");
          theText = theText.replace(/\<font color\=\"red\"\>/gi, "");
          theText = theText.replace(/\<\/font\>/gi, "");
          chrFrame.innerHTML = "<textarea name=\"editableArea\"" + " rows=\"6\" cols=\"40\" wrap=\"hard\"" + " style=\"width:300px;\">" + theText + "<\/textarea>";
        }
      };
    } else {
      var tableSugg = thisSpChObj.vWinChr.document.getElementById("suggTable");
      var suggArr = tableSugg.getElementsByTagName("td");
      var suggVal = "";
      for (var y = 0; y < suggArr.length; y++) {
        if (suggArr[y].className == "selCell") {
          suggVal = suggArr[y].innerHTML;
        }
      }
      if (suggVal == "") {
        thisSpChObj.vWinChr.alert("Please select one of the suggestions and try again!");
        PureSpellChecker.enableAll(thisSpChObj);
        return;
      }
      startIdx = thisSpChObj.docText.indexOf("\[\*\]");
      endIdx = thisSpChObj.docText.indexOf("\[\/\*\]");
      startIdx2 = thisSpChObj.docText.indexOf("\[\~\]");
      endIdx2 = thisSpChObj.docText.indexOf("\[\/\~\]");
      if (startIdx > -1 && startIdx2 > -1) {
        if (startIdx < startIdx2) {
          textSuff = thisSpChObj.docText.substring(0, startIdx);
          textPref = thisSpChObj.docText.substring(endIdx + 4);
        } else {
          textSuff = thisSpChObj.docText.substring(0, startIdx2);
          textPref = thisSpChObj.docText.substring(endIdx2 + 4);
        }
      } else if (startIdx > -1) {
        textSuff = thisSpChObj.docText.substring(0, startIdx);
        textPref = thisSpChObj.docText.substring(endIdx + 4);
      } else if (startIdx2 > -1) {
        textSuff = thisSpChObj.docText.substring(0, startIdx2);
        textPref = thisSpChObj.docText.substring(endIdx2 + 4);
      }
      thisSpChObj.docText = textSuff + suggVal + textPref;
      thisSpChObj.wordsCorrected = thisSpChObj.wordsCorrected + 1;
      thisSpChObj.currIdx = thisSpChObj.currIdx + 1;
    }
    hasMoreErrors = false;
    for (var x = thisSpChObj.currIdx; x < thisSpChObj.mySplitTxt.length; x++) {
      if (!(PureSpellChecker.isTag(thisSpChObj.mySplitTxt[x])) && PureSpellChecker.hasError(thisSpChObj.mySplitTxt[x])) {
        thisSpChObj.currIdx = x;
        hasMoreErrors = true;
        break;
      }
    }
    if (thisSpChObj.currIdx >= thisSpChObj.mySplitTxt.length || hasMoreErrors == false) {
      thisSpChObj.docText = PureSpellChecker.replaceErrorTags(thisSpChObj.docText);
      thisSpChObj.outputSystemMessage(2, new Array(thisSpChObj.totalWords, thisSpChObj.errorsFound, thisSpChObj.wordsCorrected, 1));
    } else {
      chrPane = thisSpChObj.vWinChr.document.getElementById("checkerPane");
      outText = thisSpChObj.mySplitTxt[thisSpChObj.currIdx].replace(/\[\*\]/g, "<font color=red>");
      outText = outText.replace(/\[\/\*\]/g, "<\/font>");
      outText = outText.replace(/\[\~\]/g, "<font color=red>").replace(/\[\/\~\]/g, "<\/font>");
      chrPane.innerHTML = outText;
      errRes = PureSpellChecker.getError(thisSpChObj.mySplitTxt[thisSpChObj.currIdx]);
      thisSuggestions = thisSpChObj.findSuggestions(errRes[0], errRes[1]);
      PureSpellChecker.populateSuggestions(thisSpChObj, thisSuggestions);
      PureSpellChecker.enableAll(thisSpChObj);
    }
  };
  this.vWinChr.document.getElementById("change_all_btn").onclick = function () {
    PureSpellChecker.disableAll(thisSpChObj, 1, 1, 1, 0, 1, 1, 1, 1);
    thisSpChObj.vWinChr.focus();
    var tableSugg = thisSpChObj.vWinChr.document.getElementById("suggTable");
    var suggArr = tableSugg.getElementsByTagName("td");
    var suggVal = "";
    for (var y = 0; y < suggArr.length; y++) {
      if (suggArr[y].className == "selCell") {
        suggVal = suggArr[y].innerHTML;
      }
    }
    if (suggVal == "") {
      thisSpChObj.vWinChr.alert("Please select one of the suggestions and try again!");
      PureSpellChecker.enableAll(thisSpChObj);
      return;
    }
    var hasMoreErrors = true;
    var errRes = PureSpellChecker.getError(thisSpChObj.mySplitTxt[thisSpChObj.currIdx]);
    var errWrd = errRes[0];
    var errType = 1;
    if (errRes[1] == "Y") {
      errType = 2;
    }
    var thisSuggestions = Array();
    var currIdx = thisSpChObj.currIdx;
    var startIdx = 0;
    var endIdx = 0;
    var textSuff = "";
    var textPref = "";
    var repErr = "";
    var j = 0;
    while (currIdx < thisSpChObj.mySplitTxt.length && hasMoreErrors == true) {
      if (PureSpellChecker.getError(thisSpChObj.mySplitTxt[currIdx])[0] == errWrd) {
        if (errType == 1) {
          startIdx = thisSpChObj.docText.indexOf(("\[\*\]" + errWrd));
          endIdx = thisSpChObj.docText.indexOf((errWrd + "\[\/\*\]"));
          repErr = "\[\*\]" + errWrd + "\[\/\*\]";
        } else {
          startIdx = thisSpChObj.docText.indexOf(("\[\~\]" + errWrd));
          endIdx = thisSpChObj.docText.indexOf((errWrd + "\[\/\~\]"));
          repErr = "\[\~\]" + errWrd + "\[\/\~\]";
        }
        textSuff = thisSpChObj.docText.substring(0, startIdx);
        textPref = thisSpChObj.docText.substring(endIdx + 4 + errWrd.length);
        thisSpChObj.docText = textSuff + suggVal + textPref;
        thisSpChObj.wordsCorrected = thisSpChObj.wordsCorrected + 1;
        thisSpChObj.mySplitTxt[currIdx] = thisSpChObj.mySplitTxt[currIdx].replace(repErr, suggVal);
      }
      currIdx = currIdx + 1;
      hasMoreErrors = false;
      for (j = currIdx; j < thisSpChObj.mySplitTxt.length; j++) {
        if (!(PureSpellChecker.isTag(thisSpChObj.mySplitTxt[j])) && PureSpellChecker.hasError(thisSpChObj.mySplitTxt[j])) {
          currIdx = j;
          hasMoreErrors = true;
          break;
        }
      }
    }
    thisSpChObj.currIdx = thisSpChObj.currIdx + 1;
    hasMoreErrors = false;
    for (var x = thisSpChObj.currIdx; x < thisSpChObj.mySplitTxt.length; x++) {
      if (!(PureSpellChecker.isTag(thisSpChObj.mySplitTxt[x])) && PureSpellChecker.hasError(thisSpChObj.mySplitTxt[x])) {
        thisSpChObj.currIdx = x;
        hasMoreErrors = true;
        break;
      }
    }
    if (thisSpChObj.currIdx >= thisSpChObj.mySplitTxt.length || hasMoreErrors == false) {
      thisSpChObj.docText = PureSpellChecker.replaceErrorTags(thisSpChObj.docText);
      thisSpChObj.outputSystemMessage(2, new Array(thisSpChObj.totalWords, thisSpChObj.errorsFound, thisSpChObj.wordsCorrected, 1));
    } else {
      var chrPane = thisSpChObj.vWinChr.document.getElementById("checkerPane");
      var outText = thisSpChObj.mySplitTxt[thisSpChObj.currIdx].replace(/\[\*\]/g, "<font color=red>");
      outText = outText.replace(/\[\/\*\]/g, "<\/font>");
      outText = outText.replace(/\[\~\]/g, "<font color=red>").replace(/\[\/\~\]/g, "<\/font>");
      chrPane.innerHTML = outText;
      errRes = PureSpellChecker.getError(thisSpChObj.mySplitTxt[thisSpChObj.currIdx]);
      var thisSuggestions = thisSpChObj.findSuggestions(errRes[0], errRes[1]);
      PureSpellChecker.populateSuggestions(thisSpChObj, thisSuggestions);
      PureSpellChecker.enableAll(thisSpChObj);
    }
  };
  this.vWinChr.document.getElementById("ignEdit_btn").onclick = function () {
    PureSpellChecker.disableAll(thisSpChObj, 1, 1, 1, 0, 1, 1, 1, 1);
    thisSpChObj.vWinChr.focus();
    var chrPane = "";
    var errRes = Array();
    var outText = "";
    var thisSuggestions = "";
    var startIdx = 0;
    var endIdx = 0;
    var startIdx2 = 0;
    var endIdx2 = 0;

    if (thisSpChObj.vWinChr.document.getElementById("ignEdit_btn").value == "Undo Edit") {
      var chrFrame = thisSpChObj.vWinChr.document.getElementById("checkerContentFrame");
      outText = thisSpChObj.mySplitTxt[thisSpChObj.currIdx].replace(/\[\*\]/g, "<font color=red>");
      outText = outText.replace(/\[\/\*\]/g, "<\/font>");
      outText = outText.replace(/\[\~\]/g, "<font color=red>").replace(/\[\/\~\]/g, "<\/font>");
      chrFrame.innerHTML = "<div name=\"checkerPane\" " + "id=\"checkerPane\" " + "onClick=\"\" " + "style=\"" + "border: 1px solid #667;" + "width:300px;" + "height:100px;" + "overflow:scroll;" + "overflow-x:hidden;" + "overflow-y:scroll;" + "\" >" + outText + "<\/div>";
      errRes = PureSpellChecker.getError(thisSpChObj.mySplitTxt[thisSpChObj.currIdx]);
      thisSuggestions = thisSpChObj.findSuggestions(errRes[0], errRes[1]);
      PureSpellChecker.populateSuggestions(thisSpChObj, thisSuggestions);
      PureSpellChecker.enableAll(thisSpChObj);
      thisSpChObj.vWinChr.document.getElementById("ignEdit_btn").value = "Ignore Once";
      thisSpChObj.vWinChr.document.getElementById("checkerPane").onclick = function () {
        PureSpellChecker.disableAll(thisSpChObj, 0, 1, 1, 1, 0, 1, 1, 1);
        thisSpChObj.vWinChr.focus();
        var chrFrame = thisSpChObj.vWinChr.document.getElementById("checkerContentFrame");
        var chrPane = thisSpChObj.vWinChr.document.getElementById("checkerPane");
        var editableContent = chrFrame.getElementsByTagName("textarea");
        if (editableContent.length == 0) {
          thisSpChObj.vWinChr.document.getElementById("ignEdit_btn").value = "Undo Edit";
          var theText = chrPane.innerHTML;
          theText = theText.replace(/\<font color\=red\>/gi, "");
          theText = theText.replace(/\<font color\=\"red\"\>/gi, "");
          theText = theText.replace(/\<\/font\>/gi, "");
          chrFrame.innerHTML = "<textarea name=\"editableArea\"" + " rows=\"6\" cols=\"40\" wrap=\"hard\"" + " style=\"width:300px;\">" + theText + "<\/textarea>";
        }
      };
    } else {
      startIdx = thisSpChObj.docText.indexOf("\[\*\]");
      endIdx = thisSpChObj.docText.indexOf("\[\/\*\]");
      startIdx2 = thisSpChObj.docText.indexOf("\[\~\]");
      endIdx2 = thisSpChObj.docText.indexOf("\[\/\~\]");
      if (startIdx > -1 && startIdx2 > -1) {
        if (startIdx < startIdx2) {
          thisSpChObj.docText = thisSpChObj.docText.replace(/\[\*\]/, "");
          thisSpChObj.docText = thisSpChObj.docText.replace(/\[\/\*\]/, "");
        } else {
          thisSpChObj.docText = thisSpChObj.docText.replace(/\[\~\]/, "");
          thisSpChObj.docText = thisSpChObj.docText.replace(/\[\/\~\]/, "");
        }
      } else if (startIdx > -1) {
        thisSpChObj.docText = thisSpChObj.docText.replace(/\[\*\]/, "");
        thisSpChObj.docText = thisSpChObj.docText.replace(/\[\/\*\]/, "");
      } else if (startIdx2 > -1) {
        thisSpChObj.docText = thisSpChObj.docText.replace(/\[\~\]/, "");
        thisSpChObj.docText = thisSpChObj.docText.replace(/\[\/\~\]/, "");
      }
      thisSpChObj.currIdx = thisSpChObj.currIdx + 1;
      var hasMoreErrors = false;
      for (var x = thisSpChObj.currIdx; x < thisSpChObj.mySplitTxt.length; x++) {
        if (!(PureSpellChecker.isTag(thisSpChObj.mySplitTxt[x])) && PureSpellChecker.hasError(thisSpChObj.mySplitTxt[x])) {
          thisSpChObj.currIdx = x;
          hasMoreErrors = true;
          break;
        }
      }
      if (thisSpChObj.currIdx >= thisSpChObj.mySplitTxt.length || hasMoreErrors == false) {
        thisSpChObj.docText = PureSpellChecker.replaceErrorTags(thisSpChObj.docText);
        thisSpChObj.outputSystemMessage(2, new Array(thisSpChObj.totalWords, thisSpChObj.errorsFound, thisSpChObj.wordsCorrected, 1));
      } else {
        chrPane = thisSpChObj.vWinChr.document.getElementById("checkerPane");
        outText = thisSpChObj.mySplitTxt[thisSpChObj.currIdx].replace(/\[\*\]/g, "<font color=red>");
        outText = outText.replace(/\[\/\*\]/g, "<\/font>");
        outText = outText.replace(/\[\~\]/g, "<font color=red>").replace(/\[\/\~\]/g, "<\/font>");
        chrPane.innerHTML = outText;
        errRes = PureSpellChecker.getError(thisSpChObj.mySplitTxt[thisSpChObj.currIdx]);
        thisSuggestions = thisSpChObj.findSuggestions(errRes[0], errRes[1]);
        PureSpellChecker.populateSuggestions(thisSpChObj, thisSuggestions);
        PureSpellChecker.enableAll(thisSpChObj);
      }
    }
  };
  this.vWinChr.document.getElementById("ignore_all").onclick = function () {
    PureSpellChecker.disableAll(thisSpChObj, 1, 1, 1, 0, 1, 1, 1, 1);
    thisSpChObj.vWinChr.focus();
    var hasMoreErrors = true;
    var errRes = PureSpellChecker.getError(thisSpChObj.mySplitTxt[thisSpChObj.currIdx]);
    var errWrd = errRes[0];
    var repErr = "\[\*\]" + errWrd + "\[\/\*\]";
    var errType = 1;
    if (errRes[1] == "Y") {
      repErr = "\[\~\]" + errWrd + "\[\/\~\]";
      errType = 2;
    }
    var currIdx = thisSpChObj.currIdx;
    var j = 0;
    while (currIdx < thisSpChObj.mySplitTxt.length && hasMoreErrors == true) {
      if (PureSpellChecker.getError(thisSpChObj.mySplitTxt[currIdx])[0] == errWrd) {
        thisSpChObj.docText = thisSpChObj.docText.replace(repErr, errWrd);
        thisSpChObj.mySplitTxt[currIdx] = thisSpChObj.mySplitTxt[currIdx].replace(repErr, errWrd);
      }
      currIdx = currIdx + 1;
      hasMoreErrors = false;
      for (j = currIdx; j < thisSpChObj.mySplitTxt.length; j++) {
        if (!(PureSpellChecker.isTag(thisSpChObj.mySplitTxt[j])) && PureSpellChecker.hasError(thisSpChObj.mySplitTxt[j])) {
          currIdx = j;
          hasMoreErrors = true;
          break;
        }
      }
    }
    thisSpChObj.currIdx = thisSpChObj.currIdx + 1;
    hasMoreErrors = false;
    for (var x = thisSpChObj.currIdx; x < thisSpChObj.mySplitTxt.length; x++) {
      if (!(PureSpellChecker.isTag(thisSpChObj.mySplitTxt[x])) && PureSpellChecker.hasError(thisSpChObj.mySplitTxt[x])) {
        thisSpChObj.currIdx = x;
        hasMoreErrors = true;
        break;
      }
    }
    if (thisSpChObj.currIdx >= thisSpChObj.mySplitTxt.length || hasMoreErrors == false) {
      thisSpChObj.docText = PureSpellChecker.replaceErrorTags(thisSpChObj.docText);
      thisSpChObj.outputSystemMessage(2, new Array(thisSpChObj.totalWords, thisSpChObj.errorsFound, thisSpChObj.wordsCorrected, 1));
    } else {
      var chrPane = thisSpChObj.vWinChr.document.getElementById("checkerPane");
      var outText = thisSpChObj.mySplitTxt[thisSpChObj.currIdx].replace(/\[\*\]/g, "<font color=red>");
      outText = outText.replace(/\[\/\*\]/g, "<\/font>");
      outText = outText.replace(/\[\~\]/g, "<font color=red>").replace(/\[\/\~\]/g, "<\/font>");
      chrPane.innerHTML = outText;
      errRes = PureSpellChecker.getError(thisSpChObj.mySplitTxt[thisSpChObj.currIdx]);
      var thisSuggestions = thisSpChObj.findSuggestions(errRes[0], errRes[1]);
      PureSpellChecker.populateSuggestions(thisSpChObj, thisSuggestions);
      PureSpellChecker.enableAll(thisSpChObj);
    }
  };
  this.vWinChr.document.getElementById("done_btn").onclick = function () {
    PureSpellChecker.disableAll(thisSpChObj, 1, 1, 1, 1, 1, 1, 1, 1);
    thisSpChObj.vWinChr.focus();
    thisSpChObj.docText = PureSpellChecker.replaceErrorTags(thisSpChObj.docText);
    thisSpChObj.currIdx = thisSpChObj.mySplitTxt.length;
    thisSpChObj.outputSystemMessage(2, new Array(thisSpChObj.totalWords, thisSpChObj.errorsFound, thisSpChObj.wordsCorrected, 1));
  };
  this.vWinChr.document.getElementById("add_to_dictionary").onclick = function () {
    thisSpChObj.vWinChr.focus();
    var addingMsgInstructions = "To suggest a word for the spell-cheker:\n" + "Please contact the webmaster at: " + thisSpChObj.webmasterEmail;
    thisSpChObj.vWinChr.alert(addingMsgInstructions);
    return;
  };
}

//------------------------------------------
//Output System Message method
//@param1 the number code of the message to be 
//        displayed.	
//@param2 array with parameters to output
//------------------------------------------
PureSpellChecker.prototype.outputSystemMessage = function () {
  var messageCode = arguments[0];
  var resArr = arguments[1];
  switch (messageCode) {
    case 1:
      this.vWinChr = window.open("", this.spellCheckId, this.vWinChrParam);
      this.vWinChr.opener = self;
      this.vWinChr.focus();
      this.vWinChr.document.open();
      this.vWinChr.document.write("<html>");
      this.vWinChr.document.write("<head><title>Spell Checker<\/title><\/head>");
      this.vWinChr.document.write("<body>");
      this.vWinChr.document.write("<b><font color=\"red\">Search Results:<\/font><\/b>");
      this.vWinChr.document.write("<br>");
      this.vWinChr.document.write("<font color=\"black\">Words Found:<\/font><\/b>&nbsp;<b>" + resArr[0] + "<\/b>");
      this.vWinChr.document.write("<br>");
      this.vWinChr.document.write("<font color=\"black\">Spell Errors Found:<\/font>&nbsp;<b>" + resArr[1] + "<\/b>");
      this.vWinChr.document.write("<br>");
      this.vWinChr.document.write("<font color=\"black\">Documents Searched:<\/font>&nbsp;<b>" + resArr[2] + "<\/b>");
      this.vWinChr.document.write("<br><br>");
      this.vWinChr.document.write(">><a href=\"javascript:window.close()\">");
      this.vWinChr.document.write("Click Here to Close this Window<\/a><<");
      this.vWinChr.document.write("<\/body>");
      this.vWinChr.document.write("<\/html>");
      this.vWinChr.document.close();
      break;
    case 2:
      var thisSpChObj = this;
      if (this.vWinChr == null || this.vWinChr.closed == true) {
        return;
      }
      this.vWinChr.document.open();
      this.vWinChr.document.write("<html>");
      this.vWinChr.document.write("<head><title>Spell Checker<\/title><\/head>");
      this.vWinChr.document.write("<body>");
      this.vWinChr.document.write("<b><font color=\"red\">Spell Checking Results:<\/font><\/b>");
      this.vWinChr.document.write("<br>");
      this.vWinChr.document.write("<font color=\"black\">Words Found:<\/font><\/b>&nbsp;<b>" + resArr[0] + "<\/b>");
      this.vWinChr.document.write("<br>");
      this.vWinChr.document.write("<font color=\"black\">Spell Errors Found:<\/font>&nbsp;<b>" + resArr[1] + "<\/b>");
      this.vWinChr.document.write("<br>");
      this.vWinChr.document.write("<font color=\"black\">Words Corrected:<\/font>&nbsp;<b>" + resArr[2] + "<\/b>");
      this.vWinChr.document.write("<br>");
      this.vWinChr.document.write("<font color=\"black\">Documents Searched:<\/font>&nbsp;<b>" + resArr[3] + "<\/b>");
      this.vWinChr.document.write("<br><br>");
      this.vWinChr.document.write("<p align=\"center\">");
      this.vWinChr.document.write("<input type=\"button\" ");
      this.vWinChr.document.write("value=\"Click Here to Finish\" ");
      this.vWinChr.document.write("id=\"apply_changes\" ");
      this.vWinChr.document.write("onClick=\"\" >");
      this.vWinChr.document.write("<\/p>");
      this.vWinChr.document.write("<\/body>");
      this.vWinChr.document.write("<\/html>");
      this.vWinChr.document.close();
      //New window overloaded methods
      this.vWinChr.document.getElementById("apply_changes").onclick = function () {
        thisSpChObj.vWinChr.focus();
        thisSpChObj.vWinChr.close();
        thisSpChObj = null;
      };
      var thisTextArea = document.getElementById(thisSpChObj.textAreaId);
      thisTextArea.value = thisSpChObj.docText;
      break;
    default:
      alert('No message code has been found with the parameters provided');
  }
}

//Start Progress Bar
PureSpellChecker.prototype.startProgressBar = function () {
  this.vWinChr = window.open("", this.spellCheckId, this.vWinChrParam);
  this.vWinChr.opener = self;
  this.vWinChr.focus();
  this.vWinChr.document.open();
  this.vWinChr.document.write("<html>");
  this.vWinChr.document.write("<head><title>Spell Checker<\/title><\/head>");
  this.vWinChr.document.write("<body>");
  this.vWinChr.document.write("<center>");
  this.vWinChr.document.write("<style type=\"text/css\">");
  this.vWinChr.document.write(".progBar{");
  this.vWinChr.document.write("border-top: 1px solid white;");
  this.vWinChr.document.write("border-bottom: 1px solid white;");
  this.vWinChr.document.write("border-right: 1px solid white;");
  this.vWinChr.document.write("border-left: 0px solid white;");
  this.vWinChr.document.write("}");
  this.vWinChr.document.write("<\/style>");
  this.vWinChr.document.write("<table border=\"0\" cellpadding=\"0\"");
  this.vWinChr.document.write(" cellspacing=\"0\" width=\"100%\">");
  this.vWinChr.document.write("<tr>");
  this.vWinChr.document.write("  <td><img src=\"" + this.imgPath + "invisible.gif\" border=\"0\"");
  this.vWinChr.document.write("           width=\"1\" height=\"80\"><\/td>");
  this.vWinChr.document.write("<\/tr>");
  this.vWinChr.document.write("<tr>");
  this.vWinChr.document.write("  <td align=\"center\">");
  this.vWinChr.document.write("    <span id=\"status_bar\"><\/span>");
  this.vWinChr.document.write("    <table cellspacing=\"0\" cellpadding=\"0\" ");
  this.vWinChr.document.write("     border=\"0\" bordercolor=\"white\" style=\"border-collapse:collapse;");
  this.vWinChr.document.write("     border:1px solid black\">");
  this.vWinChr.document.write("    <tr>");
  this.vWinChr.document.write("      <td id=\"p1\"><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"4\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"2\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td id=\"p2\"><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"4\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"2\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td id=\"p3\"><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"4\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"2\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td id=\"p4\"><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"4\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"2\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td id=\"p5\"><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"4\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"2\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td id=\"p6\"><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"4\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"2\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td id=\"p7\"><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"4\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"2\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td id=\"p8\"><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"4\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"2\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td id=\"p9\"><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"4\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"2\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td id=\"p10\"><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"4\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("      <td><img src=\"" + this.imgPath + "invisible.gif\" ");
  this.vWinChr.document.write("           border=\"0\" width=\"2\" height=\"22\" class=\"progBar\"><\/td>");
  this.vWinChr.document.write("    <\/tr>");
  this.vWinChr.document.write("    <\/table>");
  this.vWinChr.document.write("<\/td>");
  this.vWinChr.document.write("<\/tr>");
  this.vWinChr.document.write("<tr>");
  this.vWinChr.document.write("  <td>&nbsp;<\/td>");
  this.vWinChr.document.write("<\/tr>");
  this.vWinChr.document.write("<\/table>");
  this.vWinChr.document.write("<\/center>");
  this.vWinChr.document.write("<\/body>");
  this.vWinChr.document.write("<\/html>");
  this.vWinChr.document.close();
}

//Advance Progress Bar
PureSpellChecker.prototype.advanceProgressBar = function () {
  var thisBar = arguments[0];
  var updateAll = arguments[1];
  var barType = arguments[2];
  var barName = "";

  var thisTD, thisIMG, imgName;

  if (barType == 1) {
    barName = "progress_bar_wrd.gif";
  } else {
    barName = "progress_bar_sp.gif";
  }

  try {
    if (updateAll == true) {
      for (var i = 1; i < 11; i++) {
        thisTD = this.vWinChr.document.getElementById("p" + i);
        thisIMG = thisTD.getElementsByTagName('img')[0];
        imgName = thisIMG.src;
        if (imgName.indexOf("invisible") > -1) {
          thisIMG.src = this.imgPath + barName;
        }
      }
    } else {
      thisTD = this.vWinChr.document.getElementById("p" + thisBar);
      thisIMG = thisTD.getElementsByTagName('img')[0];
      imgName = thisIMG.src;
      if (imgName.indexOf("invisible") > -1) {
        thisIMG.src = this.imgPath + barName;
      }
    }
  } catch (err) {
    //error referencing the object
  }
}

//Update Progress Bar
PureSpellChecker.prototype.updateProgressBar = function () {
  var numIn = arguments[0];
  var calculateTime = arguments[1];

  var barType = arguments[2];

  if (calculateTime == true) {
    this.progressCounter = 1;
    this.progressInterval = ((numIn / 10) < 1) ? Math.floor((10 / numIn)) : Math.floor((numIn / 10));
    this.progressTotal = numIn;
  } else {
    if (this.progressTotal < 10) {
      for (var i = 1; i < (this.progressInterval * numIn) + 1; i++) {
        this.advanceProgressBar(i, false, barType);
      }
      if (((this.progressInterval * numIn) + this.progressInterval + 1) > this.progressTotal) {
        this.advanceProgressBar(0, true, barType);
      }
    } else {
      if (numIn == this.progressInterval * this.progressCounter && this.progressCounter < 11) {
        this.advanceProgressBar(this.progressCounter, false, barType);
        this.progressCounter = this.progressCounter + 1;
      }
    }
  }
}

//Set Status on progress bar
PureSpellChecker.prototype.setStatusBar = function () {
  var statusLabel = arguments[0];
  try {
    for (var i = 1; i < 11; i++) {
      thisTD = this.vWinChr.document.getElementById("p" + i);
      thisIMG = thisTD.getElementsByTagName('img')[0];
      imgName = thisIMG.src;
      if (imgName.indexOf("invisible") > -1) {
        thisIMG.src = this.imgPath + "invisible.gif";
      }
    }
    var thisLabel = this.vWinChr.document.getElementById("status_bar");
    thisLabel.innerHTML = statusLabel
  } catch (err) {
    //error referencing the object
  }
}

//#suggestions area

//------------------------------------------
//getWord method
//@param1 the suggested word	
//@param2 the error word
//------------------------------------------
PureSpellChecker.prototype.numMatches = function () {
  var thisWord = arguments[0];
  var targetWord = arguments[1];
  var numMatches = 0;
  var highestIdx = -1;

  var sequenceStr = "";

  for (var i = 0; i < thisWord.length; i++) {
    if (i < targetWord.length) {
      for (var j = highestIdx + 1; j < targetWord.length; j++) {
        if (thisWord.charAt(i) == targetWord.charAt(j)) {
          sequenceStr = sequenceStr + thisWord.charAt(i);
          highestIdx = j;
          break;
        }
      }
    }
  }
  
  return sequenceStr.length;
}

//------------------------------------------
//getWord method
//@param1 the index at which the word starts	
//@param2 the cluster of cylinders
//@param3 direction to move f->forward, b->backwards
//------------------------------------------
PureSpellChecker.prototype.getWord = function () {
  var startIdx = 0;
  var currPointer = 0;
  var dir = arguments[1];

  var retWord = "";

  if (dir == 'f') {
    startIdx = arguments[0] + 1;
    currPointer = startIdx + 1;
    while (this.SrcCylinder.substring(startIdx, currPointer) != "'") {
      retWord = retWord + this.SrcCylinder.substring(startIdx, currPointer);
      currPointer = currPointer + 1;
      startIdx = startIdx + 1;
    }
  } else {
    startIdx = arguments[0] - 1;
    currPointer = startIdx - 1;
    while (this.SrcCylinder.substring(currPointer, startIdx) != "'") {
      retWord = this.SrcCylinder.substring(currPointer, startIdx) + retWord;
      currPointer = currPointer - 1;
      startIdx = startIdx - 1;
    }
  }
  return retWord;
}

//------------------------------------------
//record suggestions
//@param1 the error word
//@param2 uppercase words	
//------------------------------------------
PureSpellChecker.prototype.findSuggestions = function () {
  var targetWord = arguments[0];
  //check for Caps when validating
  var upperCaseWords = arguments[1];
  var thisWord = "";
  var compositeWord = "";
  var wordIdx = 0;
  var numMatches = 0;
  var suggWordsArr = Array();
  var suggWordsArrIdx = 0;
  var suggMatchNumArr = Array();
  var suggMatchArrIdx = "";
  var highestIdx = 0;
  var seekCount = 0;
  var testCount = 0;

  var patt0 = new RegExp(this.pattC);

  if (patt0.test(targetWord.charAt(0))) {
    upperCaseWords = "Y";
  }

  targetWord = targetWord.toLowerCase();

  for (var i = 0; i < targetWord.length; i++) {
    compositeWord = compositeWord + targetWord.charAt(i);
    if (compositeWord.length > 1) {
      wordIdx = this.SrcCylinder.indexOf(("'" + compositeWord));
      if (wordIdx > -1) {
        var wR = 0;
        seekCount = 0;
        while (wR <= targetWord.length + 1) {
          thisWord = this.getWord(wordIdx, 'f');
          wR = thisWord.length;
          suggWordsArr[suggWordsArrIdx] = thisWord;
          numMatches = this.numMatches(thisWord, targetWord);
          suggMatchArrIdx = "" + numMatches + "";
          if (suggMatchNumArr[suggMatchArrIdx] == null) {
            suggMatchNumArr[suggMatchArrIdx] = suggWordsArrIdx + "";
          } else {
            suggMatchNumArr[suggMatchArrIdx] = suggMatchNumArr[suggMatchArrIdx] + "," + suggWordsArrIdx;
          }
          if (numMatches > highestIdx) {
            highestIdx = numMatches;
          }
          suggWordsArrIdx = suggWordsArrIdx + 1;
          wordIdx = this.SrcCylinder.indexOf(("'" + compositeWord), wordIdx + wR);
          if (wordIdx == -1) {
            break;
          }
          if (seekCount > 3000) {
            break;
          }
          seekCount = seekCount + 1;
        }
      }
    }
  }

  compositeWord = "";
  seekCount = 0;

  suggWordsArrIdx = suggWordsArrIdx + 1;

  for (var j = targetWord.length - 1; j > -1; j--) {
    compositeWord = targetWord.charAt(j) + compositeWord;
    if (compositeWord.length > 1) {
      wordIdx = this.SrcCylinder.indexOf((compositeWord + "'"));
      if (wordIdx > -1) {
        wordIdx = wordIdx + compositeWord.length + 1;
        var wL = 0;
        seekCount = 0;
        while (wL <= targetWord.length + 1) {
          thisWord = this.getWord(wordIdx, 'b');
          wL = thisWord.length;
          suggWordsArr[suggWordsArrIdx] = thisWord;
          numMatches = this.numMatches(thisWord, targetWord);
          suggMatchArrIdx = "" + numMatches + "";
          if (suggMatchNumArr[suggMatchArrIdx] == null) {
            suggMatchNumArr[suggMatchArrIdx] = suggWordsArrIdx + "";
          } else {
            suggMatchNumArr[suggMatchArrIdx] = suggMatchNumArr[suggMatchArrIdx] + "," + suggWordsArrIdx;
          }
          if (numMatches > highestIdx) {
            highestIdx = numMatches;
          }
          suggWordsArrIdx = suggWordsArrIdx + 1;
          wordIdx = this.SrcCylinder.indexOf((compositeWord + "'"), wordIdx + wL + 1);
          if (wordIdx == -1) {
            break;
          }
          if (seekCount > 3000) {
            break;
          }
          seekCount = seekCount + 1;
        }
      }
    }
  }

  var theseIndexes = Array();
  var resArray = Array();
  var resArrayIdx = 0;

  var currIdx = "";

  for (var k = highestIdx; k > -1; k--) {
    currIdx = "" + k + "";
    if (suggMatchNumArr[currIdx] != null) {
      theseIndexes = suggMatchNumArr[currIdx].split(",");
      for (var i = 0; i < theseIndexes.length; i++) {
        if (!PureSpellChecker.isInArray(resArray, suggWordsArr[parseInt(theseIndexes[i])])) {
          if (resArray.length < 16) {
            if (upperCaseWords == "Y") {
              resArray[resArrayIdx] = suggWordsArr[theseIndexes[i]].substr(0, 1).toUpperCase();
              resArray[resArrayIdx] = resArray[resArrayIdx] + suggWordsArr[theseIndexes[i]].substr(1);
            } else {
              resArray[resArrayIdx] = suggWordsArr[theseIndexes[i]];
            }
            resArrayIdx = resArrayIdx + 1;
          } else {
            break;
          }
        }
      }
    }
  }
  return resArray;
}

//#end of suggestions area

//#quick grammar check area

//------------------------------------------
//Perform a quick grammar check
//@param1 the text to be corrected	
//------------------------------------------
PureSpellChecker.prototype.executeGrammarCheck = function () {
  var textInput = arguments[0];
  var ps = textInput.indexOf(". ");
  var thisText = "";
  var thisTextArr = "";
  var wordCheck = "";
  var errWrd = "";
  var periodIdx = 0;
  var startIdx = 0;
  var endIdx = 0;
  var textSuff = "";
  var textPref = "";
  var errIdx = "";
  var patt0 = new RegExp(this.pattD);
  var patt1 = new RegExp(this.pattE);
  var currPointer = 0;
  var buildWord = "";
  var del = "\,\.\-\;\:\?\! ";

  var charsScanned = ps;

  while (ps != -1 && ps + 2 < textInput.length) {
    wordCheck = "";
    buildWord = "";
    errWrd = "";
    thisText = textInput.substring(ps + 2, textInput.length);

    periodIdx = thisText.indexOf(". ");

    if (periodIdx > -1) {
      thisText = thisText.substring(0, periodIdx);
    }

    thisTextArr = PureSpellChecker.splitHTMLTags(thisText, true);

    for (var q = 0; q < thisTextArr.length; q++) {
      if (!PureSpellChecker.isTag(thisTextArr[q])) {
        if (PureSpellChecker.hasError(thisTextArr[q])) {
          errWrd = PureSpellChecker.getError(thisTextArr[q])[0];
        }
        wordCheck = thisTextArr[q];
        for (var w = 0; w < wordCheck.length; w++) {
          if (patt0.test(wordCheck.charAt(w))) {
            if (patt1.test(wordCheck.charAt(w))) {
              //error Found
              currPointer = w;
              while (del.indexOf(wordCheck.charAt(currPointer)) == -1 && currPointer < wordCheck.length) {
                buildWord = buildWord + wordCheck.charAt(currPointer);
                currPointer = currPointer + 1;
              }
              errIdx = wordCheck.indexOf("\[\*\]");
              if (errWrd != "" && errIdx > -1 && errIdx <= w) {
                startIdx = textInput.indexOf(("\[\*\]" + errWrd + "\[\/\*\]"), charsScanned);
                endIdx = startIdx + errWrd.length + 7;
                textSuff = textInput.substring(0, startIdx);
                textPref = textInput.substring(endIdx);
                textInput = textSuff + "\[\~\]" + errWrd + "\[\/\~\]" + textPref;
                charsScanned = charsScanned + wordCheck.length;
              } else {
                startIdx = textInput.indexOf(buildWord, charsScanned + w);
                endIdx = startIdx + buildWord.length;
                textSuff = textInput.substring(0, startIdx);
                textPref = textInput.substring(endIdx);
                textInput = textSuff + "\[\~\]" + buildWord + "\[\/\~\]" + textPref;
                charsScanned = charsScanned + wordCheck.length + 7;
                this.errorsFound = this.errorsFound + 1;
              }
              q = thisTextArr.length;
              break;
            } else {
              charsScanned = charsScanned + wordCheck.length;
              q = thisTextArr.length;
              break;
            }
          }
        }
      } else {
        //increment the char counter
        charsScanned = charsScanned + thisTextArr[q].length;
      }
    }
    ps = textInput.indexOf(". ", charsScanned);
    charsScanned = (ps - charsScanned) + charsScanned;
    if (charsScanned == ps) {
      charsScanned = charsScanned + 1;
    }
  }
  return textInput;
}

//#end of quick grammar check area

//------------------------------------------
//Display Spell Checker method
//@param1 id of textarea field to be checked	
//@param2 language to be used
//------------------------------------------
PureSpellChecker.prototype.display = function () {
  this.mySplitTxt = Array();
  this.currIdx = 0;
  this.errorsFound = 0;
  this.wordsCorrected = 0;
  this.totalWords = 0;
  var searchText = "";
  var searchTextArr = Array();
  var resSearch = Array();
  var resSearchArr = Array();
  var resSearchWords = Array();
  var textResults = "";
  var wordFound = false;
  var wordsFound = 0;
  var strStartPosWord = 0;
  var charsScanned = 0;
  var wordsLoaded = false;
  var startApp = false;
  var theText = document.getElementById(this.textAreaId).value;

  this.docText = theText;

  if (theText.length == 0) {
    this.outputSystemMessage(1, new Array(0, 0, 1));
    return;
  }

  theText = PureSpellChecker.splitHTMLTags(theText, false)[0];
  theText = PureSpellChecker.escapeVal(theText);
  theText = theText.replace(/\&nbsp\;/g, ' ');
  theText = theText.replace(this.pattG, '');

  searchText = PureSpellChecker.formatInputString(theText);

  if (searchText.length == 0) {
    this.outputSystemMessage(1, new Array(0, 0, 1));
    return;
  }

  startApp = arguments[0];

  if (startApp == true) {
    this.startProgressBar();
    this.setStatusBar("Loading words...");
  }

  if (this.SrcCylinder == "") {
    wordsLoaded = this.initializeCylinders();
    if (wordsLoaded == false) {
      return;
    }
  }

  if (this.vWinChr == null || this.vWinChr.closed == true) {
    return;
  }

  this.setStatusBar("Processing...");
  searchTextArr = searchText.split(" ");

  this.updateProgressBar(searchTextArr.length, true, 2);

  for (var k = 0, j = 1; k < searchTextArr.length; k++) {
    wordFound = false;
    resSearch = this.searchCylinder(searchTextArr[k], this.lan);
    wordsFound = wordsFound + parseInt(resSearch[3]);
    if (resSearch[0] == true) { //do a split
      resSearchWords = PureSpellChecker.simpleSplit(resSearch[1], searchTextArr[k]);
      resSearchArr = resSearch[2].split("|");
      for (var z = 0; z < resSearchArr.length; z++) {
        wordFound = false;
        if (resSearchArr[z] == "0") {
          wordFound = false;
          this.errorsFound = this.errorsFound + 1;
        } else {
          wordFound = true;
        }
        strStartPosWord = this.docText.toLowerCase().indexOf(resSearchWords[z], charsScanned);
        if (strStartPosWord != -1) {
          if (wordFound == false) {
            this.docText = this.simpleReplace(this.docText, resSearchWords[z], charsScanned);
          }
        } else {
          if (wordFound == true) {
            this.errorsFound = this.errorsFound + 1;
          }
          this.docText = this.vectorReplace(this.docText, resSearchWords[z], charsScanned);
        }
        charsScanned = this.getCharsScanned(this.docText, resSearchWords[z], charsScanned);
      }
    } else {  //dont do a split
      if (resSearch[2].indexOf("0") != -1) {
        wordFound = false;
        this.errorsFound = this.errorsFound + 1;
      } else {
        wordFound = true;
      }
      strStartPosWord = this.docText.toLowerCase().indexOf(searchTextArr[k], charsScanned);
      if (strStartPosWord != -1) {
        if (wordFound == false) {
          this.docText = this.simpleReplace(this.docText, searchTextArr[k], charsScanned);
        }
      } else {
        if (wordFound == true) {
          this.errorsFound = this.errorsFound + 1;
        }
        this.docText = this.vectorReplace(this.docText, searchTextArr[k], charsScanned);
      }
      charsScanned = this.getCharsScanned(this.docText, searchTextArr[k], charsScanned);
    }
    this.updateProgressBar(j, false, 2);
    j = j + 1;
  }
  //quick grammar check
  if (this.checkGrammar == true) {
    this.docText = this.executeGrammarCheck(this.docText)
  }
  this.totalWords = wordsFound;
  try {
    if (this.errorsFound > 0) {
      this.outputHtmlSpellChecker(this.docText);
    } else {
      this.outputSystemMessage(1, new Array(wordsFound, this.errorsFound, 1));
    }
  } catch (e) {
    //cancel on exception
  }
}
