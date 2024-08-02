const express= require("express");
const ProductRouter=express.Router();
const auth = require("../middleware/auth");
const {Product}=require("../model/product");

// / api/products?category=Essential -- Url eg entered by user to navigate
ProductRouter.get('/api/products/',auth,async(req,res)=>{
try {
       
        const products = await Product.find({category: req.query.category});//get all the prducts as property is not mentioned
        res.json(products);
        
    } catch (error) {
        res.status(500).json({error:error.message});
    }
    });

//create a get request to search products and get them
ProductRouter.get('/api/products/search/:name',auth,async(req,res)=>{
try {
       
        const products = await Product.find({name:{$regex: req.params.name,$options:"i"},}); // this is an inbuilt mongoose regex function for search bar 
                                                                                           // name:req.params.name can also be used but it will only work when you write the complete correct name of the product ,the one that we used will provide suggestions for incomplete name also            
       
        res.json(products);
        
    } catch (error) {
        res.status(500).json({error:error.message});
    }
    });


    //creating a post request route to rate a product
    ProductRouter.post('/api/rate-product',auth,async(req,res)=>{
        try {
               const {id,rating}= req.body;
               let product = await Product.findById(id);
               for(let i=0;i<product.ratings.length;i++)
               {
                if(product.ratings[i].userId==req.user){
                    product.ratings.splice(i,1);
                    break;
                }
               }
               const ratingSchema={
                userId:req.user,
                rating,
               };
               product.ratings.push(ratingSchema);
               product= await product.save();
               res.json(product);
                
            } catch (error) {
                res.status(500).json({error:error.message});
            }
            });


  ProductRouter.get('/api/deal-of-day',auth,async(req,res)=>{
    try {
        let products= await Product.find({});
        products.sort((a,b)=>{
            let aSum=0;
            let bSum=0;
            for(let i=0;i<a.ratings.length;i++)
            {
                aSum+=a.ratings[i];
            }

            for(let i=0;i<b.ratings.length;i++)
            {
                bSum+=b.ratings[i];
            }

            return aSum<bSum? 1:-1;
        });
  res.json(products[0]);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
  })

    module.exports=ProductRouter;