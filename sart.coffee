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
		res_table.append res_tbody
		# add table as sortable
		jq$("table.list").before res_table
		res_table.tablesorter()
		# construct origin table show button 
		show_button = jq$('<button id="show_button">元の表を表示</button>').click ->
			jq$("table.list").toggle()
			false
		jq$("table.list").before show_button
		# hide origin table
		jq$("table.list").hide()

