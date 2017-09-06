/**
 * 
 */
package com.thinkgem.jeesite.common.utils.money;

import java.math.BigDecimal;

/**
 * @author J.L evan
 *
 */
public class Bead{
	
	private BigDecimal bead;

	public Bead(BigDecimal bigDecimal){
		this.bead = bigDecimal;
	}
	
	
	/**
	 * bead 的n幂次方 (this<sup>n</sup>)
	 * @param n
	 * @return 
	 */
	public Bead pow(int n) {
		bead = bead.pow(n); 
		return this;
	}

	public Bead add(Bead bead){
		return add(bead.getValue());
	}
	
	public Bead add(BigDecimal bigDecimal){
		this.bead = this.bead.add(bigDecimal);
		return this;
	}
	
	public Bead add(int i){
		this.bead = this.bead.add(new BigDecimal(i));
		return this;
	}
	public Bead add(double i){
		this.bead = this.bead.add(new BigDecimal(i));
		return this;
	}
	
	public Bead subtract(Bead bead){
		return subtract(bead.getValue());
	}
	
	public Bead subtract(BigDecimal bigDecimal){
		this.bead =this.bead.subtract(bigDecimal);
		return this;
	}
	
	public Bead subtract(int i){
		this.bead = this.bead.subtract(new BigDecimal(i));
		return this;
	}
	public Bead subtract(double i){
		this.bead = this.bead.subtract(new BigDecimal(i));
		return this;
	}
	
	public Bead multiply(Bead bead){		
		return multiply(bead.getValue());
	}
	
	public Bead multiply(int i){
		this.bead = this.bead.multiply(new BigDecimal(i));
		return this;
	}
	public Bead multiply(double i){
		this.bead = this.bead.multiply(new BigDecimal(i));
		return this;
	}
	
	public Bead multiply(BigDecimal bigDecimal){
		this.bead = this.bead.multiply(bigDecimal);
		return this;
	}

	public int compareTo(Bead bead) {
		return compareTo(bead.getValue());
	}

	public int compareToZero(){
		return compareTo(BigDecimal.ZERO);
	}
	
	public int compareTo(int i){
		return compareTo(new BigDecimal(i));
	}
	public int compareTo(double i){
		return compareTo(new BigDecimal(i));
	}
	
	public int compareTo(BigDecimal bigDecimal){
		return this.bead.compareTo(bigDecimal);
	}
	
	public Bead divide(BigDecimal big){
		return divide(big, FundAbacusUtil.DEFAULT_SCALE);
	}
	
	public Bead divide(Bead bead){
		return divide(bead.getValue(), FundAbacusUtil.DEFAULT_SCALE);
	}
	
	public Bead divide(int i){
		return divide(new BigDecimal(i),  FundAbacusUtil.DEFAULT_SCALE);
	}
	public Bead divide(double i){
		return divide(new BigDecimal(i),  FundAbacusUtil.DEFAULT_SCALE);
	}
	
	public Bead divide(Bead bead,int scale){
		return divide(bead.getValue(), scale);
	}
	
	public Bead divide(BigDecimal bigDecimal,int scale){
		if(scale<0){
			scale = FundAbacusUtil.DEFAULT_SCALE;
		}
		this.bead = this.bead.divide(bigDecimal,scale,BigDecimal.ROUND_HALF_UP);
		return this;
	}
	
	public Bead format(){
		return divide(new BigDecimal(1),FundAbacusUtil.RESULT_SCALE);
	}
	
	public BigDecimal formatToBigDecimal(){
		return format().getValue();
	}
	
	public String formatToStringDetail(){
		return formatToBigDecimal().toString();
	}
	
	public long longValue() {
		return bead.longValue();
	}

	public int intValue() {
		return bead.intValue();
	}

	public double doubleValue() {
		return bead.doubleValue();
	}
	
	public BigDecimal getValue(){
		return bead;
	}

	public BigDecimal copyValue(){
		return new BigDecimal(bead.toString());
	}

	public String toString() {
		return bead.toString();
	}
	
}
