//@ts-check
import { TestsViewManager } from "./TestsViewManager.js";
window.onload = ()=>{
    // @ts-ignore
    Main.append(new TestsViewManager({}));
}
