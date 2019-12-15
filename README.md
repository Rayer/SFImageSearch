# Image Search Safari Plugin

這個小Plugin主要功能是，當游標在圖片上的時候，右鍵選單會出現圖片搜尋的功能，點選後即可開啟新分頁導向搜尋引擎的圖片搜尋頁面。

目前支援Google跟Bing。

## 安裝

Safari App Extension跟以前的Safari Extension不同，他無法單獨安裝Safari Extension，他必須依附於一個macOS Application，所以必須要像普通App一樣拖拉進Application資料夾且點擊。

從Release頁面下載ImageSearch.app.zip，目前版本是1.0。預設我放上去的版本都是開發者簽名過且AppConnect認證過的application。
就像普通macOS App一樣，把他丟進Application
執行，按下按鈕
他會自動打開Safari Preference，把Plugin的CurrencyConverter打勾即可。

## 主要功能

就...字面上的意思，當游標在圖片上面時，右鍵可以輔助以Google或者Bing搜尋。

## 開發以及限制

由於Context Menu Item必須要在編譯期Hard Code在Info.plist內，所以動態增加搜尋引擎的支援是不可能的。如果有人想用其他搜尋引擎的話，請提供「以檔案搜尋的URL」

以Google跟Bing為例的話 就是：

Google :
`https://www.google.com/searchbyimage?&image_url=https://i.imgur.com/nRSPMeBl.jpg&safe=off`

Bing :
`https://www.bing.com/images/search?view=detailv2&iss=sbi&form=SBIHMP&sbisrc=UrlPaste&q=imgurl:https://i.imgur.com/nRSPMeBl.jpg&idpbck=1&selectedindex=0&mediaurl=https://i.imgur.com/nRSPMeBl.jpg`

目前並沒有打算API Based開發，畢竟用不到。