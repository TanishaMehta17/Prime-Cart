const express= require("express");
const authRouter =require('./routes/auth');
const mongoose= require("mongoose");
const adminRouter = require("./routes/admin");
const userRouter = require("./routes/user");
const ProductRouter = require("./routes/product");
const port=3000;
const app = express();
const DB ="mongodb+srv://tanisha:tanisha1709@cluster0.dfnyzjy.mongodb.net/?retryWrites=true&w=majority";

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(ProductRouter);
app.use(userRouter);

// MongoDB Connection
mongoose.connect(DB).then(()=>{
    console.log("connection successful");
}).catch(e=>{
    console.log(e);
});

app.listen(port,"0.0.0.0",()=>{
    console.log(`connected at port ${port}`);
});