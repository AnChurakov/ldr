jQuery(document).ready(function($){

    var host = 'http://u0044225.plsk.regruhosting.ru/api/';
    var formId  = 'frm67e449a169e14084bedf36f8cad28d9c';
    var markaId = 'frm67e449a169e14084bedf36f8cad28d9c__field1efc49618770445cbea5f01c814cdf7f';
    var modelId = 'frm67e449a169e14084bedf36f8cad28d9c__fieldeb5f55bcd06841a689dce80e3340b69b';
    var carId   = 'frm67e449a169e14084bedf36f8cad28d9c__field50a3cb12bdb74ebb952d3b61dc3ccce4';
    var buyId   = 'f346893208204392b90a2f9e12f76145';
    var buyId2  = '50c12060e1604350ac043b9edfb04b05';
    var btnsId  = 'b25972a948e44b888e0a23a6523cd9f8';


    var defMarka = '<option value="0">- выберите марку -</option>';
    var defModel = '<option value="0">- выберите модель -</option>';
    var defCar = '<option value="0">- выберите вариацию -</option>';

    var buttonsText = {
        'Велокрепления': 'velo',
        'Крепления для лыж': 'skis',
        'Автомобильные боксы': 'box',
        'Корзины': 'cart'
    };

    var form = $('#' + formId);
    var marka = $('#' + markaId);
    var model = $('#' + modelId);
    var car = $('#' + carId);
    var catalog = $('#catalog');
    var buy = $('#' + buyId);
    var buy2 = $('#' + buyId2);
    var buyForm = $('#frm' + buyId);
    var buttons = $('#' + btnsId + ' em')

    buy.hide();
    buy2.hide();
    $('.field[field-id="329b5a3cc61d476c83e02887288d33e3"]').hide();

    marka.replaceWith('<select class="inp" id="' + markaId + '">' + defMarka + '</select>');
    model.replaceWith('<select class="inp" id="' + modelId + '">' + defModel + '</select>');
    car.replaceWith('<select class="inp" id="' + carId + '">' + defCar + '</select>');

    marka = $('#' + markaId);
    model = $('#' + modelId);
    car = $('#' + carId);

    marka.change(function(){
        model.html(defModel);
        car.html(defCar);
        var id = $(this).val();
        if(id != 0){
            $.getJSON(host + 'models3/' + id + '?callback=?', function(items){
                $.each(items, function(i, item){
                    model.append('<option value="' + item.id + '">' + item.name + '</option>');
                });
            });
        }
    });

    function load(url){
        catalog.html('Загрузка...');
        $('html, body').animate({scrollTop: catalog.offset().top - 140}, 1000);

        $.getJSON(host + url + '?callback=?', function(items){
            catalog.html('<table></table>');
            var table = catalog.children();
            console.log(1);
            console.log(items);
            $.each(items, function(i, item){
                console.log(2);
				var img = item.num;
                var img_form = item.photos.substr(-4);
                var tr = '<tr>'
                + '<td class="catalog-art" style="font-weight: bold">' + item.num+'</td>'
                + '<td class="catalog-company" style="font-weight: bold">' + item.company+'</td>'
                + '<td class="catalog-descr">' 
                + item.brand+' '+item.model+' '+item.car+'-'+item.yearEnd+' '+item.volume+'<br>'
                + item.title+' '+item.ps+'<br>'
                + item.orderS+' '+item.shit1+' '+item.shit2+' '+item.shit3+' '+item.shit4+' '+item.shit5+'<br>'
                + item.weight+'кг.'
                + '</td>'
/*				
				if(item.photos == '')
                    tr += '<td class="catalog-photo"></td>';
                else
                {   
                    tr += '<td class="catalog-photo">';
                    for(var i = 0;i<imgs.length;i++)
                    {
                        var img = host + 'images3/' +imgs[i];
                        if(imgs[i].indexOf('http:__xn--80aumecw.xn--p1ai')!=-1)
                            img = 'http://xn--42-6kcux1bbo.xn--p1ai/'+imgs[i].substr('http://xn--42-6kcux1bbo.xn--p1ai/'.length);
                        else if(imgs[i].indexOf('http://')!=-1)
                            img = imgs[i];
                        tr += '<a href="' + img + '" target="_blank"><img src="' + img + '" class="has_enlarger" onclick="enlargeImage(this);return false;"></a><br>';
                    }
                    tr += '</td>'
                }
*/				
                + '<td class="catalog-photo">'
                + '<a href="' + host + 'images3/' + img + '_1_i.jpg" target="_blank"><img src="' + host + 'images3/' + img + '_1_i.jpg" class="has_enlarger" onclick="enlargeImage(this);return false;"></a><br>'
                + '<a href="' + host + 'images3/' + img + '_2_i.jpg" target="_blank"><img src="' + host + 'images3/' + img + '_2_i.jpg" class="has_enlarger" onclick="enlargeImage(this);return false;"></a><br>'
                + '<a href="' + host + 'images3/' + img + img_form + '" target="_blank"><img src="' + host + 'images3/' + img + img_form + '" class="has_enlarger" onclick="enlargeImage(this);return false;"></a><br>'
                + '</td>'
                + '<td class="catalog-price">' + item.price + ' руб.</td>'
                + '<td class="blk catalog-buy-wrapper" data-id="b-'+buyId+'"><button class="catalog-buy btn btn-form-popover btn8" data-url="'+url+'">Узнать цену</button></td>'
                + '<td class="blk zak-buy-wrapper" style="display: none" data-id="b-'+buyId2+'"><button class="zak-buy btn btn-form-popover btn8" data-url="'+url+'">Заказать</button></td>'
                + '</tr>';
                table.append(tr);
            });

            if(document.cookie.indexOf('price') > -1){
                $('td.catalog-price').show();
                $('td.zak-buy-wrapper').show();
                $('td.catalog-buy-wrapper').hide();
            }
        });
    }

    model.change(function(){
        car.html(defCar);
        var id = $(this).val();
        if(id != 0){
            $.getJSON(host + 'cars3/' + id + '?callback=?', function(items){
                $.each(items, function(i, item){
                    car.append('<option value="' + item.id + '">' + item.name + '</option>');
                });
            });
        }
    });

    form.submit(function(){
        var id = car.val();
        if(id != 0){
            load('items3/' + id);
            } else {
            alert('Выберите вариацию');
        }
        return false;
    });

    $(document).on('click', 'button.catalog-buy', function(){
        var prefix = '';
        if($(this).data('url').indexOf('items') == 0){
            prefix = marka.children('option:selected').text()+', '+model.children('option:selected').text()+', '+car.children('option:selected').text()+', ';
        }
        var item = $(this).parent().parent().find('td.catalog-name').text();

        //buyForm.find('div.frm-hint').html(item);
        //buyForm.find('textarea').val(prefix + item);

        if(buy.find('a[href]').length){
			buy.find('a[href]').trigger('click');
        } else {
			buy.find('.btn-form-popover').trigger('click');
        }
    });

    $(document).on('click', 'button.zak-buy', function(){
        if(buy2.find('a[href]').length){
        buy2.find('a[href]').trigger('click');
        } else {
        buy2.find('.btn-form-popover').trigger('click');
        }
        $('#frm50c12060e1604350ac043b9edfb04b05__field329b5a3cc61d476c83e02887288d33e3').val($(this).parents('tr').children('.catalog-price').html());
        $('#frm50c12060e1604350ac043b9edfb04b05__field2c289311f13c48e3a944215c3b7561b4').val($(this).parents('tr').children('td').eq(0).html()+' '+$(this).parents('tr').children('td').eq(2).html());
    });
	var inter;
    buyForm.submit(function(){
		if($('#frmf346893208204392b90a2f9e12f76145__fieldf14ce1c24e884e3db4c300dd0fad8669').val()=='111'){
			$('td.catalog-price').show();
            $('td.zak-buy-wrapper').show();
		    $('td.catalog-buy-wrapper').hide();
		    $('#wind_container .wind-close').click();
		    document.cookie = 'price=show';
			return false;
		}
		inter = setInterval(checkForm,200);
    });

    var winClose = false;

    $('.wind-close').click(function(){
        clearInterval(inter);
        winClose= true;
    })

	function checkForm(){
        if(winClose)
            return false;
		if($('#wind_container').css('display')=='none')
		{
			clearInterval(inter);
			$('td.catalog-price').show();
            $('td.zak-buy-wrapper').show();
		    $('td.catalog-buy-wrapper').hide();
		    document.cookie = 'price=show';
		}
	}

    buttons.css('cursor', 'pointer');
    //buttons.on('click', function(){
    //    load(buttonsText[$(this).text()]);
    //});

    $.getJSON(host + 'brands3?callback=?', function(items){
        $.each(items, function(i, item){
            marka.append('<option value="' + item.id + '">' + item.name + '</option>');
        });
    });

});


//DELETE
function forCSV(){
	function getCountStrInStr(substr,str)
	{
		var a=0;
		while(str.indexOf(substr)!=-1)
		{
			a++;
			str = str.substr(0,str.indexOf(substr))+str.substr(str.indexOf(substr)+substr.length);
		}
		return a;
	}

	var csv;
	var csvArray;
	$.get('/template/projects/test/far.csv',{},function(data){
		csv=data;
		csvArray=data.split('\n');
		for(var i in csvArray)
			if(getCountStrInStr('|',csvArray[i])==9)
				csvArray[i]+='|';
		csv = csvArray.join('\n');
		$('body').html(csv);
	})

    var csv;
    var csvArray;
    var last=[];
    var fori=0;
    $.get('/template/projects/test/far.csv',{},function(data){
        csv=data;
        csvArray=data.split('\n');
        for(var i in csvArray){
            csvArray[i]=csvArray[i].split('|');
            if(i==0)
            {
                last[0]=csvArray[i][1];
                last[1]=csvArray[i][2];
                last[2]=csvArray[i][3];
            }else if(!((last[0]==csvArray[i][1])&&(last[1]==csvArray[i][2])&&(last[2]==csvArray[i][3]))){
                fori++;
                last[0]=csvArray[i][1];
                last[1]=csvArray[i][2];
                last[2]=csvArray[i][3];
            }
            csvArray[i].splice(1,0,fori);
        }
        for(var i=0;i<20;i++)
            console.log(csvArray[i]);
        for(var i in csvArray)
            csvArray[i]=csvArray[i].join('|');
        csv=csvArray.join('\n');
        $('body').html(csv);
    })

    var csv;
    var csvArray;
    $.get('/template/projects/test/far.csv?v=2',{},function(data){
        csv=data;
        csvArray=data.split('\n');
        for(var i in csvArray)
        {
            if(i<5)
                continue;
            csvArray[i]=csvArray[i].split('|');
            csvArray[i][24]=Math.round(parseInt(csvArray[i][8])/66*100)/100;
            csvArray[i]=csvArray[i].join('|');
        }
        csv = csvArray.join('\n');
        console.log(csv);
        $('body').html(csv);
        /*csvArray=csv.split('\n');
        for(var i in csvArray)
        {
            console.log(csvArray[i].split('|').length)
        }*/
    })

    var csv;
    var csvArray;
    $.get('/template/projects/test/far.csv?v=2',{},function(data){
        //var data = $('body').html();
        csv=data;
        csvArray=data.split('\n');
        for(var i in csvArray)
        {
            console.log(csvArray[i].split('|').length)
        }
    })
}

function delCookie(name) {
  document.cookie = name + "=" + "; expires=Thu, 01 Jan 1970 00:00:01 GMT";
}