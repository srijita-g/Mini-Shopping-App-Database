
const products = [
  { name: "Laptop", brand: "HP", price: 70000, rating: 4.5 },
  { name: "T-Shirt", brand: "Zara", price: 500, rating: 4.0 },
  { name: "Book", brand: "Pearson", price: 300, rating: 3.8 }
];

const users = [
  { name: "Srijita", type: "Admin" },
  { name: "Rahul", type: "Customer" },
  { name: "Ananya", type: "Customer" }
];

const orders = [
  { id: 1, status: "Placed", amount: 70000 },
  { id: 2, status: "Delivered", amount: 1000 }
];

const productDiv = document.getElementById("products");
products.forEach(p => {
  productDiv.innerHTML += `
    <div class="card">
      <h3>${p.name}</h3>
      <p>Brand: ${p.brand}</p>
      <p class="price">₹${p.price}</p>
      <p>⭐ ${p.rating}</p>
      <button>Add to Cart</button>
    </div>
  `;
});

const userDiv = document.getElementById("users");
users.forEach(u => {
  userDiv.innerHTML += `
    <div class="card">
      <h3>${u.name}</h3>
      <p>Type: ${u.type}</p>
    </div>
  `;
});

const orderDiv = document.getElementById("orders");
orders.forEach(o => {
  orderDiv.innerHTML += `
    <div class="card">
      <h3>Order #${o.id}</h3>
      <p>Status: ${o.status}</p>
      <p class="price">₹${o.amount}</p>
    </div>
  `;
});