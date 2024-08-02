const mongoose=require("mongoose");
const{ productSchema }=require('./product');
const orderSchema = mongoose.Schema({
    products:[
        {
            product:productSchema,
            quantity:{
                type:Number,
                required:true,
            },
        },
    ],
    totalPrice:{
        type:Number,
        required:true,
    },
    address:{
        type:String,
        required:true,
    },
    userId:{
      required:true,
      type:String,
    },
    orderedAt:{
        type:Number,
        required:true,
    },
    status:{
        type:Number,
        default:0, // 0 means pending just placed the order 
                    //1 means completed dispatched from the seller
                    //2 means recieved 
                    //3 means delivered
    },

});

const Order = mongoose.model('Order',orderSchema);
module.exports = Order;