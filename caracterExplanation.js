
var characters = [4096,65600]
//var numeros=  [0,1,2,3,4,5,6,7];
var numeros=  [8,9,10,11,12,13,14,15];
var texdiv4 = numeros.map(n =>  (n/4.0) )
var mod2 = texdiv4.map(n =>  (n % 2) )
var minus1 = mod2.map(n =>  (n -1) )
var multx = minus1.map(n =>  (n *4) +2.5 )
var multy = minus1.map(n =>  n *(-4) +2.5)
var coefy = multy.map(n =>  (n *5) )
var exp2rows = []
for (var j = 2; j < coefy.length; j++){

    var cols = []
    for(var i = 2; i < multx.length; i++) {
        cols.push( parseInt( (characters[0]/Math.pow(2,multx[i]+coefy[j])) % 2  ) )
    }
    exp2rows.push(cols)
}

console.log(numeros,texdiv4, mod2,minus1,multx,multy)
console.log("exp",exp2rows)
