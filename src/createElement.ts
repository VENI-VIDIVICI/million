import { propsDriver } from './drivers/props';
import { flushWorkStack } from './patch';
import { DOMNode, OLD_VNODE_FIELD, VNode } from './types';

/**
 * Creates an Element from a VNode
 */
export const createElement = (vnode: VNode, attachField = true): DOMNode => {
  if (typeof vnode === 'string') return document.createTextNode(vnode);
  const el = <HTMLElement>document.createElement(vnode.tag);

  flushWorkStack(propsDriver(el, vnode));

  if (vnode.children) {
    for (let i = 0; i < vnode.children.length; ++i) {
      el.appendChild(createElement(vnode.children[i]));
    }
  }

  if (attachField) el[OLD_VNODE_FIELD] = vnode;

  return el;
};
