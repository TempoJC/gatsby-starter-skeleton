import React from "react";
import { render } from "@testing-library/react";
import Footer from "../Footer";

describe("Footer", () => {
  it("renders correctly", () => {
    const tree = render(<Footer />);
    expect(tree.container).toMatchSnapshot();
  });
});
