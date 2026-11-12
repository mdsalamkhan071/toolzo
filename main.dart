import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const ToolzoApp());

const navy = Color(0xFF071426);
const panel = Color(0xFF10243D);
const orange = Color(0xFFFF8A00);
const blue = Color(0xFF168BFF);

class ToolzoApp extends StatelessWidget {
  const ToolzoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'TOOLZO',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: navy,
      colorScheme: ColorScheme.fromSeed(seedColor: orange, brightness: Brightness.dark),
      appBarTheme: const AppBarTheme(backgroundColor: navy, foregroundColor: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: panel,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      ),
    ),
    home: const HomePage(),
  );
}

class ToolItem {
  final String name, category, description;
  final IconData icon;
  const ToolItem(this.name, this.category, this.description, this.icon);
}

const tools = <ToolItem>[
  ToolItem('Basic Calculator','Calculator','Add, subtract, multiply and divide.',Icons.calculate),
  ToolItem('Percentage','Education','Find percentage of a number.',Icons.percent),
  ToolItem('GST Calculator','Finance','Calculate GST amount and total.',Icons.receipt_long),
  ToolItem('EMI Calculator','Finance','Estimate monthly loan payment.',Icons.payments),
  ToolItem('Discount Calculator','Finance','Calculate sale price and savings.',Icons.sell),
  ToolItem('BMI Calculator','Health','Calculate body mass index.',Icons.monitor_heart),
  ToolItem('Simple Interest','Finance','Calculate simple interest.',Icons.account_balance_wallet),
  ToolItem('Compound Interest','Finance','Estimate compound growth.',Icons.trending_up),
  ToolItem('Average Calculator','Education','Find the average of numbers.',Icons.functions),
  ToolItem('Length Converter','Converter','Convert units using a multiplier.',Icons.straighten),
  ToolItem('Weight Converter','Converter','Convert units using a multiplier.',Icons.scale),
  ToolItem('Temperature Converter','Converter','Convert Celsius to Fahrenheit.',Icons.thermostat),
  ToolItem('Data Converter','Converter','Convert MB to KB.',Icons.data_usage),
  ToolItem('Electricity Estimate','Daily Life','Estimate bill from units and rate.',Icons.bolt),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  String query = '';
  String category = 'All';
  final categories = const ['All','Calculator','Finance','Daily Life','Education','Converter','Health'];

  @override
  Widget build(BuildContext context) {
    final visible = tools.where((t) =>
      (category == 'All' || t.category == category) &&
      (t.name.toLowerCase().contains(query.toLowerCase()) ||
       t.description.toLowerCase().contains(query.toLowerCase()))
    ).toList();

    return Scaffold(
      appBar: AppBar(title: Row(children: [
        Container(width: 38,height: 38,decoration: BoxDecoration(
          gradient: const LinearGradient(colors:[orange,Color(0xFFFFC247)]),
          borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.handyman,color: navy)),
        const SizedBox(width: 10),
        const Text('TOOL',style: TextStyle(fontWeight: FontWeight.w900,letterSpacing: 1.2)),
        const Text('ZO',style: TextStyle(color: orange,fontWeight: FontWeight.w900,letterSpacing: 1.2)),
      ])),
      body: SafeArea(child: Column(children:[
        Padding(padding:const EdgeInsets.fromLTRB(16,8,16,12),child:Container(
          width:double.infinity,padding:const EdgeInsets.all(18),
          decoration:BoxDecoration(
            gradient:const LinearGradient(colors:[Color(0xFF12345A),Color(0xFF0B1D33)]),
            borderRadius:BorderRadius.circular(22),border:Border.all(color:blue.withOpacity(.45))),
          child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Text('YOUR EVERYDAY TOOLKIT',style:TextStyle(color:orange,fontWeight:FontWeight.bold,letterSpacing:1.1,fontSize:12)),
            SizedBox(height:8),Text('Everything useful.\\nOne simple app.',style:TextStyle(fontSize:25,fontWeight:FontWeight.w800,height:1.15)),
            SizedBox(height:7),Text('Quick • Simple • No sign-in required',style:TextStyle(color:Colors.white70)),
          ]),
        )),
        Padding(padding:const EdgeInsets.symmetric(horizontal:16),child:TextField(
          onChanged:(v)=>setState(()=>query=v),
          decoration:const InputDecoration(prefixIcon:Icon(Icons.search),hintText:'Search tools...'),
        )),
        SizedBox(height:54,child:ListView.separated(
          padding:const EdgeInsets.symmetric(horizontal:16,vertical:10),scrollDirection:Axis.horizontal,
          itemCount:categories.length,separatorBuilder:(_,__)=>const SizedBox(width:8),
          itemBuilder:(context,i){final c=categories[i];final selected=c==category;return ChoiceChip(
            label:Text(c),selected:selected,onSelected:(_)=>setState(()=>category=c),
            selectedColor:orange,labelStyle:TextStyle(color:selected?navy:Colors.white,fontWeight:FontWeight.w700),
            backgroundColor:panel,side:BorderSide.none);},
        )),
        Expanded(child:visible.isEmpty
          ? const Center(child:Text('No tools found. Try another search.'))
          : GridView.builder(
            padding:const EdgeInsets.fromLTRB(16,4,16,20),
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,mainAxisSpacing:12,crossAxisSpacing:12,childAspectRatio:1.12),
            itemCount:visible.length,
            itemBuilder:(context,i){final t=visible[i];return InkWell(
              borderRadius:BorderRadius.circular(18),
              onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>ToolPage(tool:t))),
              child:Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(
                color:panel,borderRadius:BorderRadius.circular(18),border:Border.all(color:blue.withOpacity(.22))),
                child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                  Container(width:43,height:43,decoration:BoxDecoration(color:orange.withOpacity(.15),borderRadius:BorderRadius.circular(13)),
                    child:Icon(t.icon,color:orange,size:25)),
                  const Spacer(),Text(t.name,style:const TextStyle(fontWeight:FontWeight.bold,fontSize:15)),
                  const SizedBox(height:4),Text(t.description,maxLines:2,overflow:TextOverflow.ellipsis,style:const TextStyle(color:Colors.white60,fontSize:11)),
                ]),
              ),
            );},
          )),
      ])),
    );
  }
}

class ToolPage extends StatefulWidget {
  final ToolItem tool;
  const ToolPage({super.key,required this.tool});
  @override State<ToolPage> createState()=>_ToolPageState();
}
class _ToolPageState extends State<ToolPage> {
  final a=TextEditingController(), b=TextEditingController(), c=TextEditingController();
  String result='';
  @override void dispose(){a.dispose();b.dispose();c.dispose();super.dispose();}
  double n(TextEditingController x)=>double.tryParse(x.text.trim())??0;
  String fmt(double v)=>v.isFinite?v.toStringAsFixed(2):'Invalid input';

  void calculate(){
    final x=n(a), y=n(b), z=n(c);
    double r=0; String label='Result';
    switch(widget.tool.name){
      case 'Basic Calculator':
        final op=c.text.trim();
        if(op=='+')r=x+y;
        else if(op=='-')r=x-y;
        else if(op=='×'||op=='*')r=x*y;
        else if(op=='÷'||op=='/') {
          if(y==0){setState(()=>result='Cannot divide by zero');return;}
          r=x/y;
        } else {setState(()=>result='Enter +, -, × or ÷ in the operator field');return;}
        break;
      case 'Percentage': r=x*y/100; label='$y% of $x'; break;
      case 'GST Calculator': r=x*y/100; label='GST: ${fmt(r)}  |  Total: ${fmt(x+r)}'; break;
      case 'EMI Calculator':
        if(x<=0||y<=0||z<=0){setState(()=>result='Enter loan amount, annual interest rate and months.');return;}
        final m=y/1200;
        r=x*m*math.pow(1+m,z)/ (math.pow(1+m,z)-1);
        label='Monthly EMI'; break;
      case 'Discount Calculator':
        r=x-(x*y/100); label='You save ${fmt(x*y/100)}  |  Sale price'; break;
      case 'BMI Calculator':
        if(y<=0){setState(()=>result='Enter height in centimetres.');return;}
        r=x/((y/100)*(y/100)); label='BMI'; break;
      case 'Simple Interest': r=x*y*z/100; label='Interest'; break;
      case 'Compound Interest': r=x*math.pow(1+y/100,z)-x; label='Interest earned'; break;
      case 'Average Calculator':
        final vals=a.text.split(',').map((e)=>double.tryParse(e.trim())).whereType<double>().toList();
        if(vals.isEmpty){setState(()=>result='Enter numbers separated by commas.');return;}
        r=vals.reduce((p,q)=>p+q)/vals.length; label='Average'; break;
      case 'Length Converter': r=x*y; label='Converted length'; break;
      case 'Weight Converter': r=x*y; label='Converted weight'; break;
      case 'Temperature Converter': r=(x*9/5)+32; label='Fahrenheit (°F)'; break;
      case 'Data Converter': r=x*1024; label='Kilobytes (KB)'; break;
      case 'Electricity Estimate': r=x*y; label='Estimated bill (₹)'; break;
      default: setState(()=>result='This tool is coming soon.');return;
    }
    setState(()=>result='$label: ${fmt(r)}');
  }

  @override Widget build(BuildContext context){
    final name=widget.tool.name;
    String first='Enter first value', second='Enter second value', third='Optional';
    if(name=='Percentage'){first='Number';second='Percentage (%)';}
    if(name=='GST Calculator'){first='Amount (₹)';second='GST rate (%)';}
    if(name=='EMI Calculator'){first='Loan amount (₹)';second='Annual interest rate (%)';third='Tenure in months';}
    if(name=='Discount Calculator'){first='Original price (₹)';second='Discount (%)';}
    if(name=='BMI Calculator'){first='Weight (kg)';second='Height (cm)';}
    if(name=='Simple Interest'||name=='Compound Interest'){first='Principal amount';second='Annual rate (%)';third='Time (years)';}
    if(name=='Average Calculator'){first='Numbers separated by commas';}
    if(name=='Length Converter'||name=='Weight Converter'){first='Value';second='Conversion multiplier';}
    if(name=='Temperature Converter'){first='Temperature in Celsius';}
    if(name=='Data Converter'){first='Megabytes (MB)';}
    if(name=='Electricity Estimate'){first='Units consumed (kWh)';second='Rate per unit (₹)';}
    if(name=='Basic Calculator'){first='First number';second='Second number';third='Operator (+, -, ×, ÷)';}

    return Scaffold(appBar:AppBar(title:Text(name)),body:ListView(padding:const EdgeInsets.all(20),children:[
      Container(padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(18)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Icon(widget.tool.icon,color:orange,size:38),const SizedBox(height:10),
        Text(widget.tool.description,style:const TextStyle(color:Colors.white70)),
      ])),
      const SizedBox(height:20),
      TextField(controller:a,keyboardType:name=='Average Calculator'?TextInputType.text:const TextInputType.numberWithOptions(decimal:true),decoration:InputDecoration(labelText:first)),
      if(name!='Average Calculator') ...[
        const SizedBox(height:12),
        TextField(controller:b,keyboardType:const TextInputType.numberWithOptions(decimal:true),decoration:InputDecoration(labelText:second)),
      ],
      if(['EMI Calculator','Simple Interest','Compound Interest','Basic Calculator'].contains(name)) ...[
        const SizedBox(height:12),
        TextField(controller:c,keyboardType:name=='Basic Calculator'?TextInputType.text:TextInputType.number,decoration:InputDecoration(labelText:third)),
      ],
      const SizedBox(height:18),
      FilledButton.icon(onPressed:calculate,icon:const Icon(Icons.calculate),label:const Text('Calculate'),
        style:FilledButton.styleFrom(backgroundColor:orange,foregroundColor:navy,padding:const EdgeInsets.all(15))),
      if(result.isNotEmpty) ...[
        const SizedBox(height:18),
        Container(padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:orange.withOpacity(.13),borderRadius:BorderRadius.circular(16),border:Border.all(color:orange)),
          child:Text(result,style:const TextStyle(fontSize:18,fontWeight:FontWeight.bold,color:Colors.white))),
      ],
      const SizedBox(height:18),
      const Text('Note: Results are estimates. Verify important financial calculations independently.',style:TextStyle(color:Colors.white54,fontSize:12)),
    ]));
  }
}
