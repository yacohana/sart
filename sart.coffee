# Title : sart (Student Affairs information system Results Table overrider)
# Author : @yacohana
jq$ ->
	return if jq$('#res_table')[0] # re-called
	jq$.getScript "https://yacohana.info/sart/assets/jquery.tablesorter.min.js", ->
		# load css
		jq$("head").append '<link>'
		css = jq$("head").children ':last'
		css.attr {
				rel: 'stylesheet'
				type: 'text/css'
				href: 'https://yacohana.info/sart/assets/style.css'
		}
		# html result table -> Array data[][]
		data = []
		jq$('tr').each (i) ->
			data[i] = []
			jq$('td', jq$(@)).each (j) ->
				data[i][j] = jq$(@).text().trim()
		# construct table tag
		res_table = jq$('<table id="res_table">')
		res_tr = jq$('<tr>')
		res_tr.append '<th>分野名</th><th>系列名</th><th>科目名</th>'
		for str, i in data[1]
			res_tr.append("<th>#{str}</th>") if !(i==0||i==4)
		res_table.append jq$('<thead>').append(res_tr)
		res_tbody = jq$('<tbody>')
		# construct table body
		flag = false # group name twice
		ratings = new Object # ratings count
		credits = new Object # credits count
		for row, i in data
			continue if i < 2
			if row.length < 2 # group name
				if flag
					lgroup = sgroup # small/large group
					sgroup = row[0]
				else
					sgroup = row[0]
				flag = true
			else
				flag = false
				res_tr = jq$('<tr>')
				res_tr.append "<td>#{lgroup}</td><td>#{sgroup}</td>"
				for str, j in row
					res_tr.append "<td>#{str}</td>" if j!=4
				res_tbody.append res_tr
				ratings[row[5]] = 0 unless ratings[row[5]]?
				credits[row[5]] = 0 unless credits[row[5]]?
				ratings[row[5]] += 1
				credits[row[5]] += parseInt row[3] if [row[3]]?
		res_table.append res_tbody
		# add table as sortable
		jq$("table.list").before res_table
		res_table.tablesorter( {sortList: [[7,1], [8,1]]} )
		# construct control buttons 
		show_button = jq$('<button id="show_button">元の表を表示</button>').click ->
			jq$("table.list").toggle()
			false
		sort_button = jq$('<button id="sort_button">セメスター順に並べ替え</button>').click ->
			sorting = [[7,0],[8,0]]
			res_table.trigger("sorton",[sorting])
			false
		sort_rev_button = jq$('<button id="sort_rev_button">セメスター逆順に並べ替え</button>').click ->
			sorting = [[7,1],[8,1]]
			res_table.trigger("sorton",[sorting])
			false
		count_button = jq$('<button id="count_button">評価/単位数カウント</button>').click ->
			str = "<p><strong>評価数カウント</strong><br>"
			sum = 0
			for rating, val of ratings
				if val? and !isNaN val and val != 0
					if rating is ""
						str += "評価なし : #{val}<br>"
					else
						str += "#{rating} : #{val}<br>"
					sum += val
			str += "合計 : #{sum}</p><hr><br><p><strong>単位数カウント</strong><br>"
			sum = 0
			for credit, val of credits
				if val? and !isNaN val and val != 0
					if credit is ""
						str += "評価なし : #{val}<br>"
					else
						str += "#{credit} : #{val}<br>"
					sum += val
			str += "合計 : #{sum}</p><hr><br>"
			count_float = jq$("<div id='count_float'>#{str}<div>")
			openFloatDialog(count_float,300,"評価/単位数カウント")
			false
		jq$("table.list").before show_button
		res_table.before sort_button
		res_table.before sort_rev_button
		res_table.before count_button
		# hide origin table
		jq$("table.list").hide()
