import React from "react";

function App() {
  return (
    <div className="flex items-center justify-center min-h-screen bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500 text-white text-center">
      <div className="p-10 bg-white bg-opacity-20 rounded-2xl shadow-lg">
        <h1 className="text-5xl font-bold animate-pulse">Welcome to RK Website</h1>
        <p className="mt-4 text-lg">Deployed using DevOps CI/CD Pipeline</p>
      </div>
    </div>
  );
}

export default App;

