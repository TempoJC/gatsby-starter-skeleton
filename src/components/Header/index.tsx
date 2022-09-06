import React from "react";

const Header = () => (
  <header>
    <nav className="py-8 bg-white">
      <div className="md:container px-4 md:px-0 mx-auto flex justify-between">
        <img
          className="w-16"
          src="https://capp.nicepage.com/bf483e57c95e271afd13aa25e2ecbbe017068d1d/images/default-logo.png"
          alt=""
        />
        <div className="space-y-1.5 cursor-pointer">
          <div className="h-1 w-8 bg-gray-600 rounded"></div>
          <div className="h-1 w-8 bg-gray-600 rounded"></div>
          <div className="h-1 w-8 bg-gray-600 rounded"></div>
        </div>
      </div>
    </nav>
  </header>
);

export default Header;
