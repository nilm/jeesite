package com.thinkgem.jeesite.common.utils.shield;

public class ShieldUnit {
	private boolean mask;
	private double length;
	private int maskLength;

	public boolean getMask() {
		return mask;
	}

	public void setMask(boolean mask) {
		this.mask = mask;
	}

	public double getLength() {
		return length;
	}

	public void setLength(double length) {
		this.length = length;
	}

	public int getMaskLength() {
		return maskLength;
	}

	public void setMaskLength(int maskLength) {
		this.maskLength = maskLength;
	}

	public ShieldUnit() {
		super();
	}

	public ShieldUnit(boolean mask, double length) {
		super();
		this.mask = mask;
		this.length = length;
	}

	public ShieldUnit(boolean mask, double length, int maskLength) {
		super();
		this.mask = mask;
		this.length = length;
		this.maskLength = maskLength;
	}

}
