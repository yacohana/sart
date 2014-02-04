# 成績照会の表を見やすくするbookmarklet

## 何が出来るか
これ↓が  
![Before](/sart/assets/before.png)  
こう↓なります。  
![After](/sart/assets/after.png)


## 使い方

**何かあっても責任は取れないので、各自の判断でご利用ください。**

### 分かる人向け

[これ][99]をブックマークレットとして成績照会ページで使ってください。  
表タイトル行クリックでソート、Shift+クリックで複数行ソートできます。

### 詳しく

* Chrome
    
    1. ブックマークバーが表示されていない場合、`Ctrl+Shift+B`で表示
    1. ブックマークバーで右クリック→ページを追加
    1. URLに下の文字列をコピペ。名前は適当に
    1. ブックマークバーに保存
    1. 成績照会ページ(成績一覧の表が出ているページ)に移動
    1. さっき作ったブックマークを押す


```
javascript:se=document.createElement('SCRIPT');se.setAttribute('language','JavaScript');se.setAttribute('src','https://yacohana.info/sart/sart.js');document.body.appendChild(se);
```

* Firefox
 
    1. [ここ][99]を右クリック→このリンクをブックマーク
    1. ブックマークツールバーに保存。名前は適当に
    1. 成績照会ページ(成績一覧の表が出ているページ)に移動
    1. ブックマークツールバーが表示されていない場合、`Ctrl+B`で表示
    1. さっき作ったブックマークを押す

* IE

    * 知らん


##　その他(Q&A)

* 成績情報を勝手に送られるの？

	いいえ。bookmarletでJavaScriptを読み込んで、ブラウザ上で処理しているのでこちらに成績データは送られていません。  
	不安であれば[ここ][1]からソースを確認するか、それでも不安であれば使うのを諦めてください。

* ～～の環境で動かない/バグ etc...

	まともなブラウザで、JavaScriptがオンであることを確かめてください。それでも動かない場合は[Twitter][2]にバグ報告貰えれば直すかもしれません。  
	もちろんPRは大歓迎。

* なんで作ったの？

    試験勉強の息抜きと、CoffeeScriptの勉強。

* 使用ライブラリ

    表部分にがっつり[tablesoter][4]を利用させて頂きました。あとjQuery。


---
[Source][1] (ライセンス:[NYSL 0.9981][3])  
[yacohana(Twitter)][2]

[1]: http://github.hoge	"Github"
[2]: http://twitter.com/yacohana "yacohana(Twitetr)"
[3]: http://www.kmonos.net/nysl/ "NYSL"
[4]: http://tablesorter.com/docs/ "Tablesoter"
[99]: javascript:se=document.createElement('SCRIPT');se.setAttribute('language','JavaScript');se.setAttribute('src','https://yacohana.info/sart/sart.js');document.body.appendChild(se); "sart-bookmarklet"