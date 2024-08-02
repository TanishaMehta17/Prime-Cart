const express= require("express");
const User= require("../model/user");
const jwt = require("jsonwebtoken");
const bcryptjs= require("bcryptjs");
const auth = require("../middleware/auth");
const authRouter = express.Router();

//post request
authRouter.post('/api/signup', async(req,res)=>{
   //get the data from the clinet 
   //console.log(reg.body);  // get the data from the user
  try{
    const{name,email,password}= req.body;
  const existingUser= await User.findOne({ email });
  if(existingUser){
    return res.status(400).json({msg:"User with same email already esist!"}); // status code 400 means a bad request the error is from the client side
  }

 const hashPassword= await bcryptjs.hash(password,8);
// const hashPassword = bcryptjs.hashSync(password, 8);
  let user= new User ({ // don't use const here use var or let preferrable is let(seq doesn't matter just write all the required field of your schema)
    email,
    password:hashPassword,
    name,
  });
  user = await  user.save();
  res.json(user);
  }catch(e){
    res.status(500).json({error:e.message});
  }
});

//Sign In route
authRouter.post('/api/signin',async(req,res)=>{
  try {
    const {email,password}=req.body;
    const user = await User.findOne({ email });
    if(!user)
    {
      return res.status(400).json({msg :"User with this email does not exist"});
    }

    //checking the hashpassword
    //do not convert the user entered password to the hashpassword and then compare that witht the databse as they both will be different always use compare functionn they wil be dfferent because of asalt that adds a random string to the password
    const isMatch=await bcryptjs.compare(password,user.password);
    if(!isMatch){
      return res.status(400).json({msg :"Incorrect Password"});
    }

    const token= jwt.sign({id: user._id},"passwordKey");
    res.json({token,...user._doc})//this...with add token : token to the user object detail
  } catch (e) {
    res.status(500).json({error:e.message});
  }
})

//get user data route
authRouter.post('/tokenIsValid',async(req,res)=>{
  try {
   const token = req.header('x-auth-token');
   if(!token)
   return res.json(false);
  const verified= jwt.verify(token,"passwordKey");
   if(!verified)
   return res.json(false);
   
   const user = await User.findById(verified.id);
   if(!user)
   return res.json(false);
  res.json(true);
  } catch (e) {
    res.status(500).json({error:e.message});
  }
});

authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});
//auth is the middleware
module.exports=authRouter;